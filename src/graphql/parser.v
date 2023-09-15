module graphql

pub struct ParserOptions {
pub:
	// By default, the parser creates AST nodes that know the location
	// in the source that they correspond to. This configuration flag
	// disables that behavior for performance or testing.
	no_location ?bool
	// Parser CPU and memory usage is linear to the number of tokens in a document
	// however in extreme cases it becomes quadratic due to memory exhaustion.
	// Parsing happens before validation so even invalid queries can burn lots of
	// CPU time and memory.
	// To prevent this you can set a maximum number of tokens allowed within a document.
	max_tokens int = 1000
	// @deprecated
	allow_legacy_fragment_variables            ?bool
	experimental_client_controlled_nullability ?bool
}

[heap]
pub struct Parser {
	options ParserOptions
mut:
	lexer         Lexer
	token_counter int
}

type SourceOrString = Source | string

fn Parser.new(source SourceOrString, options ?ParserOptions) !Parser {
	// initial empty source
	mut source_object := Source.new('', none, none)

	if source is string {
		source_object = Source.new(source, none, none)
	} else {
		source_object = source as Source
	}

	return Parser{
		lexer: Lexer.new(source_object)
		options: options or { ParserOptions{} }
		token_counter: 0
	}
}

pub fn parse(source SourceOrString, options ?ParserOptions) !DocumentNode {
	mut parser := Parser.new(source, options)!
	return parser.parse_document() or { panic(err) }
}

// pub fn parse_value(source SourceOrString, options ?ParserOptions) !ValueNode {
// 	mut parser := Parser.new(source, options)!

// 	parser.expect_token(TokenKind.sof)!

// 	value := parser
// }

fn (mut p Parser) parse_value_literal(is_const bool) !ValueNode {
	token := p.lexer.token

	match token.kind {
		.bracket_l {
			return p.parse_list(is_const)!
		}
		.brace_l {
			return p.parse_object(is_const)!
		}
		.integer {
			p.advance_lexer()!

			return p.node[IntValueNode](token, mut IntValueNode{
				kind: Kind.int_value
				value: token.value
			})!
		}
		.float {
			p.advance_lexer()!

			return p.node[FloatValueNode](token, mut FloatValueNode{
				kind: Kind.float_value
				value: token.value
			})!
		}
		.string_value, .block_string {
			return p.parse_string_literal() or { StringValueNode{} }
		}
		.dollar {
			if is_const {
				p.expect_token(TokenKind.dollar)!

				if p.lexer.token.kind == TokenKind.name {
					var_name := p.lexer.token.value
					error('Unexpected variable ${var_name}')
				} else {
					p.unexpected(token)!
				}
			}

			return p.parse_variable()!
		}
		.name {
			p.advance_lexer()!

			match token.value or { '' } {
				'true' {
					return p.node[BooleanValueNode](token, mut BooleanValueNode{
						kind: Kind.boolean
						value: true
					})!
				}
				'false' {
					return p.node[BooleanValueNode](token, mut BooleanValueNode{
						kind: Kind.boolean
						value: false
					})!
				}
				'null' {
					return p.node[NullValueNode](token, mut NullValueNode{
						kind: Kind.null
					})!
				}
				else {
					return p.node[EnumValueNode](token, mut EnumValueNode{
						kind: Kind.enum_value
						value: token.value or { '' }
					})!
				}
			}
		}
		else {
			p.unexpected(none)!
			return error('')
		}
	}
}

fn (mut p Parser) parse_variable() !VariableNode {
	start := p.lexer.token

	p.expect_token(TokenKind.dollar)!

	return p.node[VariableNode](start, mut VariableNode{
		kind: Kind.variable
		name: p.parse_name()!
	})
}

fn (mut p Parser) parse_list(is_const bool) !ListValueNode {
	item := fn [mut p, is_const] () !ValueNode {
		return p.parse_value_literal(is_const)!
	}

	p.expect_token(TokenKind.dollar)!

	return p.node[ListValueNode](p.lexer.token, mut ListValueNode{
		kind: Kind.list
		values: p.any(TokenKind.bracket_l, item, TokenKind.bracket_r)
	})
}

fn (mut p Parser) parse_object(is_const bool) !ObjectValueNode {
	item := fn [mut p, is_const] () !ObjectFieldNode {
		return p.parse_object_field(is_const)
	}

	return p.node[ObjectValueNode](p.lexer.token, mut ObjectValueNode{
		kind: Kind.object
		fields: p.any(TokenKind.brace_l, item, TokenKind.brace_r)
	})
}

// ObjectField[Const] : Name : Value[?Const]
fn (mut p Parser) parse_object_field(is_const bool) !ObjectFieldNode {
	start := p.lexer.token
	name := p.parse_name()!

	p.expect_token(TokenKind.colon)!

	return p.node[ObjectFieldNode](start, mut ObjectFieldNode{
		kind: Kind.object_field
		name: name
		value: p.parse_value_literal(is_const)!
	})
}

fn (mut p Parser) parse_name() !NameNode {
	token := p.expect_token(TokenKind.name)!
	node := p.node[NameNode](token, mut NameNode{
		kind: Kind.name
		value: token.value or { '' }
	})!

	return node
}

fn (mut p Parser) parse_document() !DocumentNode {
	definitions := p.many(TokenKind.sof, p.parse_definition, TokenKind.eof)
	doc := p.node[DocumentNode](p.lexer.token, mut DocumentNode{
		kind: Kind.document
		definitions: definitions
	}) or { panic(err) }

	return doc
}

// Definition :
//   - ExecutableDefinition
//   - TypeSystemDefinition
//   - TypeSystemExtension
//
// ExecutableDefinition :
//   - OperationDefinition
//   - FragmentDefinition
//
// TypeSystemDefinition :
//   - SchemaDefinition
//   - TypeDefinition
//   - DirectiveDefinition
//
// TypeDefinition :
//   - ScalarTypeDefinition
//   - ObjectTypeDefinition
//   - InterfaceTypeDefinition
//   - UnionTypeDefinition
//   - EnumTypeDefinition
//   - InputObjectTypeDefinition
fn (mut p Parser) parse_definition() !DefinitionNode {
	if p.peek(TokenKind.brace_l) or { false } {
		return p.parse_operation_definition()!
	}

	has_description := p.peek_description()
	keyword_token := if has_description {
		p.lexer.lookahead() or { panic('') }
	} else {
		p.lexer.token
	}

	println(keyword_token.value)
	if keyword_token.kind == TokenKind.name {
		match keyword_token.value or { '' } {
			'schema' {
				return p.parse_schema_definition()!
			}
			else {
				return error('parse_definition')
			}
		}
	}

	return error('Could not parse definitions')
}

fn (mut p Parser) parse_description() ?StringValueNode {
	if p.peek_description() {
		return p.parse_string_literal()
	}

	return none
}

fn (mut p Parser) parse_string_literal() ?StringValueNode {
	token := p.lexer.token
	p.advance_lexer() or { return none }

	node := p.node[StringValueNode](token, mut StringValueNode{
		kind: Kind.string_value
		value: token.value
		block: token.kind == TokenKind.block_string
	}) or { return none }

	return node
}

fn (p Parser) parse_const_value_literal() ?ConstValueNode {
	return none
}

fn (mut p Parser) parse_schema_definition() !SchemaDefinitionNode {
	start := p.lexer.token
	description := p.parse_description()

	p.expect_keyword('schema')!

	operation_types := p.many(TokenKind.brace_l, p.parse_operation_type_definition, TokenKind.brace_r)

	node := p.node[SchemaDefinitionNode](start, mut SchemaDefinitionNode{
		kind: Kind.schema_definition
		description: description
		directives: []
		operation_types: operation_types
	})!

	return node
}

fn (mut p Parser) parse_operation_definition() !OperationDefinitionNode {
	start := p.lexer.token

	if p.peek(TokenKind.brace_l)! {
		node := p.node[OperationDefinitionNode](start, mut OperationDefinitionNode{
			kind: Kind.operation_definition
			operation: OperationTypeNode.query
			name: none
			variable_definitions: []
			directives: []
			selection_set: SelectionSetNode{}
		})!

		return node
	}

	operation := p.parse_operation_type()!
	mut name := NameNode{}

	if p.peek(TokenKind.name)! {
		name = p.parse_name()!
	}

	node := p.node[OperationDefinitionNode](start, mut OperationDefinitionNode{
		kind: Kind.operation_definition
		operation: operation
		name: name
		variable_definitions: []
		directives: none
		selection_set: SelectionSetNode{}
	})!

	return node
}

fn (mut p Parser) parse_named_type() !NamedTypeNode {
	node := p.node[NamedTypeNode](p.lexer.token, mut NamedTypeNode{
		kind: Kind.named_type
		name: p.parse_name()!
	})!

	return node
}

fn (mut p Parser) parse_operation_type() !OperationTypeNode {
	operation_token := p.expect_token(TokenKind.name)!

	return match operation_token.value or { '' } {
		'query' {
			OperationTypeNode.query
		}
		'mutation' {
			OperationTypeNode.mutation
		}
		'subscription' {
			OperationTypeNode.subscription
		}
		else {
			error('Unexpected token')
		}
	}
}

fn (mut p Parser) parse_operation_type_definition() !OperationTypeDefinitionNode {
	start := p.lexer.token

	operation := p.parse_operation_type()!
	p.expect_token(TokenKind.colon)!

	@type := p.parse_named_type()!

	node := p.node[OperationTypeDefinitionNode](start, mut OperationTypeDefinitionNode{
		kind: Kind.operation_type_definition
		operation: operation
		@type: @type
	})!

	return node
}

fn (p Parser) peek_description() bool {
	return p.peek(TokenKind.string_value) or { false } || p.peek(TokenKind.block_string) or {
		false
	}
}

// Returns a node that, if configured to do so, sets a "loc" field as a
// location object, used to identify the place in the source that created a
// given parsed object.
fn (p Parser) node[T](start_token Token, mut node ASTNodeInterface) !T {
	println('IN!')
	if !p.options.no_location? {
		node.loc = Location.new(start_token, p.lexer.last_token, p.lexer.source)
	}

	if mut node is T {
		return *node
	}

	return error('failed to convert node')
}

// Determines if the next token is of a given kind
fn (p Parser) peek(kind TokenKind) !bool {
	return p.lexer.token.kind == kind
}

// If the next token is of the given kind, return that token after advancing the lexer.
// Otherwise, do not change the parser state and throw an error.
fn (mut p Parser) expect_token(kind TokenKind) !Token {
	token := p.lexer.token

	if token.kind != kind {
		error('Expected ${kind.gql_str()} got ${token.kind.gql_str()}')
	}

	p.advance_lexer()!
	return token
}

// If the next token is of the given kind, return "true" after advancing the lexer.
// Otherwise, do not change the parser state and return "false".
fn (mut p Parser) expect_optional_token(kind TokenKind) !bool {
	token := p.lexer.token

	if token.kind == kind {
		p.advance_lexer()!
		return true
	}

	return false
}

// If the next token is a given keyword, advance the lexer.
// Otherwise, do not change the parser state and throw an error.
fn (mut p Parser) expect_keyword(value string) ! {
	token := p.lexer.token
	val := token.value or { '' }

	if token.kind == TokenKind.name && val == value {
		p.advance_lexer()!
	}

	return error('Expected ${value}, got ${token.value}')
}

// If the next token is a given keyword, return "true" after advancing the lexer.
// Otherwise, do not change the parser state and return "false".
fn (mut p Parser) expect_optional_keyword(value string) !bool {
	token := p.lexer.token
	val := token.value or { '' }

	if token.kind == TokenKind.name && val == value {
		p.advance_lexer()!
		return true
	}

	return false
}

// Helper function for creating an error when an unexpected lexed token is encountered.
fn (p Parser) unexpected(at_token ?Token) ! {
	match at_token {
		none {
			error('Unexpected token ${at_token.str()}')
		}
		else {
			at_token
		}
	}
}

// Returns a possibly empty list of parse nodes, determined by the parseFn.
// This list begins with a lex token of openKind and ends with a lex token of closeKind.
// Advances the parser to the next lex token after the closing token.
fn (mut p Parser) any[T](open_kind TokenKind, parse_fn fn () T, close_kind TokenKind) []T {
	p.expect_token(open_kind) or { panic('err') }
	mut nodes := []T{}

	for {
		if p.expect_optional_token(close_kind) or { false } {
			break
		}

		nodes << parse_fn()
	}

	return nodes
}

// Returns a list of parse nodes, determined by the parseFn.
// It can be empty only if open token is missing otherwise it will always return non-empty list
// that begins with a lex token of openKind and ends with a lex token of closeKind.
// Advances the parser to the next lex token after the closing token.
fn (p Parser) optional_many[T](open_kind TokenKind, parse_fn fn () T, close_kind TokenKind) []T {
	nodes:
	[]T{} := []

	if p.expect_optional_token(open_kind) {
		for {
			if p.expect_optional_token(close_kind) {
				break
			}

			nodes << parse_fn()
		}
	}

	return nodes
}

fn (mut p Parser) many[T](open_kind TokenKind, parse_fn fn () !T, close_kind TokenKind) []T {
	p.expect_token(open_kind) or { panic(err) }
	mut nodes := []T{}

	loop1: for {
		if p.expect_optional_token(close_kind) or { break loop1 } {
			break loop1
		}

		result := parse_fn() or { panic(err) }
		dump(result)
		nodes << result
	}

	println('ever finished?')
	return nodes
}

fn (p Parser) delimited_many[T](delimiter_kind TokenKind, parse_fn fn () T) []T {
	p.expect_optional_token(delimiter_kind)
	nodes:
	[]T{} := []

	for {
		if !p.expect_optional_token(delimiter_kind) {
			break
		}

		nodes << parse_fn()
	}

	return nodes
}

fn (mut p Parser) advance_lexer() ! {
	token := p.lexer.advance() or { panic('could not advance lexer') }

	max_tokens := p.options.max_tokens

	if max_tokens != -1 && token.kind != TokenKind.eof {
		p.token_counter += 1

		if p.token_counter > max_tokens {
			error('Document contains more than ${max_tokens}. Aborting')
		}
	}
}

fn get_token_kind_desc(kind TokenKind) string {
	if is_punctuator_token_kind(kind) {
		return '"${kind.gql_str()}"'
	}

	return kind.gql_str()
}
