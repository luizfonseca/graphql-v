# module src.graphql

## Contents

- [print_block_string](#print_block_string)
- [parse](#parse)
- [is_printable_as_block_string](#is_printable_as_block_string)
- [get_location](#get_location)
- [IDirectiveNode](#IDirectiveNode)
- [ASTNodeInterface](#ASTNodeInterface)
- [DefinitionNode](#DefinitionNode)
- [NullabilityAssertionNode](#NullabilityAssertionNode)
- [ExecutableDefinitionNode](#ExecutableDefinitionNode)
- [SelectionNode](#SelectionNode)
- [TypeSystemExtensionNode](#TypeSystemExtensionNode)
- [ValueNode](#ValueNode)
- [NonNullType](#NonNullType)
- [ASTNode](#ASTNode)
- [TypeDefinitionNode](#TypeDefinitionNode)
- [TypeDirectives](#TypeDirectives)
- [TypeExtensionNode](#TypeExtensionNode)
- [TypeNode](#TypeNode)
- [TypeSystemDefinitionNode](#TypeSystemDefinitionNode)
- [Kind](#Kind)
  - [gql_str](#gql_str)
- [TokenKind](#TokenKind)
  - [gql_str](#gql_str)
- [OperationTypeNode](#OperationTypeNode)
  - [gql_str](#gql_str)
- [DirectiveLocation](#DirectiveLocation)
- [InterfaceTypeDefinitionNode](#InterfaceTypeDefinitionNode)
- [InterfaceTypeExtensionNode](#InterfaceTypeExtensionNode)
- [IntValueNode](#IntValueNode)
- [Lexer](#Lexer)
- [ListNullabilityOperatorNode](#ListNullabilityOperatorNode)
- [ListTypeNode](#ListTypeNode)
- [ListValueNode](#ListValueNode)
- [Location](#Location)
- [NamedTypeNode](#NamedTypeNode)
- [NameNode](#NameNode)
- [NonNullAssertionNode](#NonNullAssertionNode)
- [NonNullTypeNode](#NonNullTypeNode)
- [NullValueNode](#NullValueNode)
- [ObjectFieldNode](#ObjectFieldNode)
- [ObjectTypeDefinitionNode](#ObjectTypeDefinitionNode)
- [ObjectTypeExtensionNode](#ObjectTypeExtensionNode)
- [ObjectValueNode](#ObjectValueNode)
- [OperationDefinitionNode](#OperationDefinitionNode)
- [OperationTypeDefinitionNode](#OperationTypeDefinitionNode)
- [Parser](#Parser)
- [ParserOptions](#ParserOptions)
- [ScalarTypeDefinitionNode](#ScalarTypeDefinitionNode)
- [ScalarTypeExtensionNode](#ScalarTypeExtensionNode)
- [SchemaDefinitionNode](#SchemaDefinitionNode)
- [SchemaExtensionNode](#SchemaExtensionNode)
- [SelectionSetNode](#SelectionSetNode)
- [Source](#Source)
- [StringValueNode](#StringValueNode)
- [Token](#Token)
- [UnionTypeDefinitionNode](#UnionTypeDefinitionNode)
- [UnionTypeExtensionNode](#UnionTypeExtensionNode)
- [VariableDefinitionNode](#VariableDefinitionNode)
- [VariableNode](#VariableNode)
- [BlockStringOptions](#BlockStringOptions)
- [BooleanValueNode](#BooleanValueNode)
- [ConstArgumentNode](#ConstArgumentNode)
- [ConstObjectFieldNode](#ConstObjectFieldNode)
- [ConstObjectValueNode](#ConstObjectValueNode)
- [DirectiveDefinitionNode](#DirectiveDefinitionNode)
- [DirectiveNode](#DirectiveNode)
- [DocumentNode](#DocumentNode)
- [EnumTypeDefinitionNode](#EnumTypeDefinitionNode)
- [EnumTypeExtensionNode](#EnumTypeExtensionNode)
- [EnumValueDefinitionNode](#EnumValueDefinitionNode)
- [EnumValueNode](#EnumValueNode)
- [ErrorBoundaryNode](#ErrorBoundaryNode)
- [FieldDefinitionNode](#FieldDefinitionNode)
- [FieldNode](#FieldNode)
- [FloatValueNode](#FloatValueNode)
- [FragmentDefinitionNode](#FragmentDefinitionNode)
- [FragmentSpreadNode](#FragmentSpreadNode)
- [InlineFragmentNode](#InlineFragmentNode)
- [InputObjectTypeDefinitionNode](#InputObjectTypeDefinitionNode)
- [InputObjectTypeExtensionNode](#InputObjectTypeExtensionNode)
- [InputValueDefinitionNode](#InputValueDefinitionNode)

## print_block_string

```v
fn print_block_string(value string, options ?BlockStringOptions) ?string
```

Print a block string in the indented block form by adding a leading and trailing blank line.  
However, if a block string starts with whitespace and is a single-line, adding a leading blank line would strip that whitespace.

[[Return to contents]](#Contents)

## parse

```v
fn parse(source SourceOrString, options ?ParserOptions) !DocumentNode
```

[[Return to contents]](#Contents)

## is_printable_as_block_string

```v
fn is_printable_as_block_string(value string) bool
```

Check if a string is printable as a block string.

[[Return to contents]](#Contents)

## get_location

```v
fn get_location(source Source, position int) !SourceLocation
```

getLocation takes a Source and a UTF-8 character offset,
and returns the corresponding line and column as a SourceLocation.

[[Return to contents]](#Contents)

## IDirectiveNode

```v
interface IDirectiveNode {
	kind Kind
	name NameNode
	arguments ?[]ArgumentNode
mut:
	loc ?Location
}
```

[[Return to contents]](#Contents)

## ASTNodeInterface

```v
interface ASTNodeInterface {
mut:
	loc ?Location
}
```

All AST Nodes should implement a MUTable common loc property

[[Return to contents]](#Contents)

## DefinitionNode

```v
type DefinitionNode = DirectiveDefinitionNode
	| EnumTypeDefinitionNode
	| FragmentDefinitionNode
	| InputObjectTypeDefinitionNode
	| InterfaceTypeDefinitionNode
	| ObjectTypeDefinitionNode
	| OperationDefinitionNode
	| ScalarTypeDefinitionNode
	| SchemaDefinitionNode
	| SchemaExtensionNode
	| TypeExtensionNode
	| UnionTypeDefinitionNode
```

[[Return to contents]](#Contents)

## NullabilityAssertionNode

```v
type NullabilityAssertionNode = ErrorBoundaryNode
	| ListNullabilityOperatorNode
	| NonNullAssertionNode
```

[[Return to contents]](#Contents)

## ExecutableDefinitionNode

```v
type ExecutableDefinitionNode = FragmentDefinitionNode | OperationDefinitionNode
```

[[Return to contents]](#Contents)

## SelectionNode

```v
type SelectionNode = FieldNode | FragmentSpreadNode | InlineFragmentNode
```

[[Return to contents]](#Contents)

## TypeSystemExtensionNode

```v
type TypeSystemExtensionNode = SchemaExtensionNode | TypeExtensionNode
```

[[Return to contents]](#Contents)

## ValueNode

```v
type ValueNode = BooleanValueNode
	| ConstObjectValueNode
	| EnumValueNode
	| FloatValueNode
	| IntValueNode
	| ListValueNode
	| NullValueNode
	| ObjectValueNode
	| StringValueNode
	| VariableNode
```

--

[[Return to contents]](#Contents)

## NonNullType

```v
type NonNullType = ListTypeNode | NamedTypeNode
```

[[Return to contents]](#Contents)

## ASTNode

```v
type ASTNode = ArgumentNode
	| BooleanValueNode
	| DirectiveDefinitionNode
	| DirectiveNode
	| DocumentNode
	| EnumTypeDefinitionNode
	| EnumTypeExtensionNode
	| EnumValueDefinitionNode
	| EnumValueNode
	| ErrorBoundaryNode
	| FieldDefinitionNode
	| FieldNode
	| FloatValueNode
	| FragmentDefinitionNode
	| FragmentSpreadNode
	| InlineFragmentNode
	| InputObjectTypeDefinitionNode
	| InputObjectTypeExtensionNode
	| InputValueDefinitionNode
	| IntValueNode
	| InterfaceTypeDefinitionNode
	| InterfaceTypeExtensionNode
	| ListNullabilityOperatorNode
	| ListTypeNode
	| ListValueNode
	| NameNode
	| NamedTypeNode
	| NonNullAssertionNode
	| NonNullTypeNode
	| NullValueNode
	| ObjectFieldNode
	| ObjectTypeDefinitionNode
	| ObjectTypeExtensionNode
	| ObjectValueNode
	| OperationDefinitionNode
	| OperationTypeDefinitionNode
	| ScalarTypeDefinitionNode
	| ScalarTypeExtensionNode
	| SchemaDefinitionNode
	| SchemaExtensionNode
	| SelectionSetNode
	| StringValueNode
	| UnionTypeDefinitionNode
	| UnionTypeExtensionNode
	| VariableDefinitionNode
	| VariableNode
```

The list of all possible AST node types.

[[Return to contents]](#Contents)

## TypeDefinitionNode

```v
type TypeDefinitionNode = EnumTypeDefinitionNode
	| InputObjectTypeDefinitionNode
	| InterfaceTypeDefinitionNode
	| ObjectTypeDefinitionNode
	| ScalarTypeDefinitionNode
	| UnionTypeDefinitionNode
```

Type definition

[[Return to contents]](#Contents)

## TypeDirectives

```v
type TypeDirectives = DirectiveNode
```

Directives

[[Return to contents]](#Contents)

## TypeExtensionNode

```v
type TypeExtensionNode = EnumTypeExtensionNode
	| InputObjectTypeExtensionNode
	| InterfaceTypeExtensionNode
	| ObjectTypeExtensionNode
	| ScalarTypeExtensionNode
	| UnionTypeExtensionNode
```

Type Extensions

[[Return to contents]](#Contents)

## TypeNode

```v
type TypeNode = ListTypeNode | NamedTypeNode | NonNullTypeNode
```

Type reference

[[Return to contents]](#Contents)

## TypeSystemDefinitionNode

```v
type TypeSystemDefinitionNode = DirectiveDefinitionNode
	| SchemaDefinitionNode
	| TypeDefinitionNode
```

Type system definition

[[Return to contents]](#Contents)

## Kind

```v
enum Kind {
	name
	document
	// Documen
	operation_definition
	variable_definition
	selection_set
	field
	argument
	// Nullability Modifier
	list_nullability_operator
	non_null_assertion
	error_boundary
	// Fragments *
	fragment_spread
	inline_fragment
	fragment_definition
	// Value
	variable
	int_value
	float_value
	string_value
	boolean
	null
	enum_value
	list
	object
	object_field
	// Directive
	directive
	// Type
	named_type
	list_type
	non_null_type
	// Type System Definition
	schema_definition
	operation_type_definition
	// Type Definition
	scalar_type_definition
	object_type_definition
	field_definition
	input_value_definition
	interface_type_definition
	union_type_definition
	enum_type_definition
	enum_value_definition
	input_object_type_definition
	// Directive Definition
	directive_definition
	// Type System Extension
	schema_extension
	// Type Extension
	scalar_type_extension
	object_type_extension
	interface_type_extension
	union_type_extension
	enum_type_extension
	input_object_type_extension
}
```

[[Return to contents]](#Contents)

## gql_str

```v
fn (k Kind) gql_str() string
```

Returns the string value of the Kind enum

[[Return to contents]](#Contents)

## TokenKind

```v
enum TokenKind {
	sof
	eof
	bang
	question_mark
	dollar
	amp
	paren_l
	paren_r
	spread
	colon
	equals
	at
	bracket_l
	bracket_r
	brace_l
	pipe
	brace_r
	name
	integer
	float
	string_value
	block_string
	comment
}
```

An exported enum describing the different kinds of tokens that the
lexer emits.

[[Return to contents]](#Contents)

## gql_str

```v
fn (t TokenKind) gql_str() string
```

Returns the character value of the TokenKind enum

[[Return to contents]](#Contents)

## OperationTypeNode

```v
enum OperationTypeNode {
	query
	mutation
	subscription
}
```

[[Return to contents]](#Contents)

## gql_str

```v
fn (o OperationTypeNode) gql_str() string
```

[[Return to contents]](#Contents)

## DirectiveLocation

```v
enum DirectiveLocation {
	// Request Definitions
	query
	mutation
	subscription
	field
	fragment_definition
	fragment_spread
	inline_fragment
	variable_definition
	// Type System Definitions
	schema
	scalar
	object
	field_definition
	argument_definition
	@interface
	@union
	@enum
	enum_value
	input_object
	input_field_definition
}
```

[[Return to contents]](#Contents)

## InterfaceTypeDefinitionNode

```v
struct InterfaceTypeDefinitionNode {
	kind        Kind = Kind.interface_type_definition
	description ?StringValueNode
	name        NameNode
	interfaces  ?[]NamedTypeNode
	directives  ?[]DirectiveNode
	fields      ?[]FieldDefinitionNode
pub mut:
	loc ?Location
}
```

[[Return to contents]](#Contents)

## InterfaceTypeExtensionNode

```v
struct InterfaceTypeExtensionNode {
	kind       Kind = Kind.interface_type_extension
	name       NameNode
	interfaces ?[]NamedTypeNode
	directives ?[]DirectiveNode
	fields     ?[]FieldDefinitionNode
pub mut:
	loc ?Location
}
```

[[Return to contents]](#Contents)

## IntValueNode

```v
struct IntValueNode {
pub:
	kind     Kind = Kind.int_value
	value    ?string
	is_const bool
pub mut:
	loc ?Location
}
```

[[Return to contents]](#Contents)

## Lexer

```v
struct Lexer {
pub:
	source Source
mut:
	line_start int
	line       int
	last_token &Token
	token      &Token
}
```

[[Return to contents]](#Contents)

## ListNullabilityOperatorNode

```v
struct ListNullabilityOperatorNode {
pub:
	kind                  Kind = Kind.list_nullability_operator
	nullability_assertion ?NullabilityAssertionNode
pub mut:
	loc ?Location
}
```

[[Return to contents]](#Contents)

## ListTypeNode

```v
struct ListTypeNode {
pub:
	kind      Kind = Kind.list_type
	node_type TypeNode
pub mut:
	loc ?Location
}
```

[[Return to contents]](#Contents)

## ListValueNode

```v
struct ListValueNode {
pub:
	kind     Kind = Kind.list
	values   []ValueNode
	is_const bool
pub mut:
	loc ?Location
}
```

[[Return to contents]](#Contents)

## Location

```v
struct Location {
pub:
	// The character offset at which this Node begins.
	start int
	// The character offset at which this Node ends.
	end int
	// The Token at which this Node begins.
	start_token ?&Token
	// The Token at which this Node ends.
	end_token ?&Token
	// The Source document the AST represents.
	source Source
}
```

[[Return to contents]](#Contents)

## NamedTypeNode

```v
struct NamedTypeNode {
pub:
	kind      Kind = Kind.named_type
	node_type NameNode
pub mut:
	loc ?Location
}
```

[[Return to contents]](#Contents)

## NameNode

```v
struct NameNode {
pub:
	kind  Kind = Kind.name
	value string
pub mut:
	loc ?Location
}
```

[[Return to contents]](#Contents)

## NonNullAssertionNode

```v
struct NonNullAssertionNode {
pub:
	kind                  Kind = Kind.non_null_assertion
	nullability_assertion ?ListNullabilityOperatorNode
pub mut:
	loc ?Location
}
```

[[Return to contents]](#Contents)

## NonNullTypeNode

```v
struct NonNullTypeNode {
pub:
	kind      Kind = Kind.non_null_type
	node_type NonNullType
pub mut:
	loc ?Location
}
```

[[Return to contents]](#Contents)

## NullValueNode

```v
struct NullValueNode {
pub:
	kind     Kind = Kind.null
	is_const bool
pub mut:
	loc ?Location
}
```

[[Return to contents]](#Contents)

## ObjectFieldNode

```v
struct ObjectFieldNode {
pub:
	kind     Kind = Kind.object_field
	name     NameNode
	value    ValueNode
	is_const bool
pub mut:
	loc ?Location
}
```

[[Return to contents]](#Contents)

## ObjectTypeDefinitionNode

```v
struct ObjectTypeDefinitionNode {
	kind        Kind
	description ?StringValueNode
	name        NameNode
	interfaces  ?[]NamedTypeNode
	directives  ?[]DirectiveNode
	fields      ?[]FieldDefinitionNode
pub mut:
	loc ?Location
}
```

[[Return to contents]](#Contents)

## ObjectTypeExtensionNode

```v
struct ObjectTypeExtensionNode {
	kind       Kind = Kind.object_type_extension
	name       NameNode
	interfaces ?[]NamedTypeNode
	directives ?[]DirectiveNode
	fields     ?[]FieldDefinitionNode
pub mut:
	loc ?Location
}
```

[[Return to contents]](#Contents)

## ObjectValueNode

```v
struct ObjectValueNode {
pub:
	kind     Kind = Kind.object
	fields   []ObjectFieldNode
	is_const bool
pub mut:
	loc ?Location
}
```

[[Return to contents]](#Contents)

## OperationDefinitionNode

```v
struct OperationDefinitionNode {
pub:
	kind                 Kind = Kind.operation_definition
	operation            OperationTypeNode
	name                 ?NameNode
	variable_definitions ?[]VariableDefinitionNode
	directives           ?[]DirectiveNode
	selection_set        SelectionSetNode
pub mut:
	loc ?Location
}
```

[[Return to contents]](#Contents)

## OperationTypeDefinitionNode

```v
struct OperationTypeDefinitionNode {
pub:
	kind      Kind = Kind.operation_type_definition
	operation OperationTypeNode
	@type     NamedTypeNode
pub mut:
	loc ?Location
}
```

[[Return to contents]](#Contents)

## Parser

```v
struct Parser {
	options ParserOptions
mut:
	lexer         Lexer
	token_counter int
}
```

[[Return to contents]](#Contents)

## ParserOptions

```v
struct ParserOptions {
pub:
	// By default, the parser creates AST nodes that know the location
	// in the source that they correspond to. This configuration flag
	// disables that behavior for performance or testing.
	no_location bool
	// Parser CPU and memory usage is linear to the number of tokens in a document
	// however in extreme cases it becomes quadratic due to memory exhaustion.
	// Parsing happens before validation so even invalid queries can burn lots of
	// CPU time and memory.
	// To prevent this you can set a maximum number of tokens allowed within a document.
	// @default 50K tokens
	max_tokens int = 50_000
	// @deprecated
	allow_legacy_fragment_variables            ?bool
	experimental_client_controlled_nullability ?bool
}
```

[[Return to contents]](#Contents)

## ScalarTypeDefinitionNode

```v
struct ScalarTypeDefinitionNode {
	kind        Kind
	description ?StringValueNode
	name        NameNode
	directives  ?[]DirectiveNode
pub mut:
	loc ?Location
}
```

[[Return to contents]](#Contents)

## ScalarTypeExtensionNode

```v
struct ScalarTypeExtensionNode {
	kind       Kind = Kind.scalar_type_extension
	name       NameNode
	directives ?[]DirectiveNode
pub mut:
	loc ?Location
}
```

[[Return to contents]](#Contents)

## SchemaDefinitionNode

```v
struct SchemaDefinitionNode {
pub:
	kind            Kind = Kind.schema_definition
	description     ?StringValueNode
	directives      ?[]DirectiveNode
	operation_types []OperationTypeDefinitionNode
pub mut:
	loc ?Location
}
```

[[Return to contents]](#Contents)

## SchemaExtensionNode

```v
struct SchemaExtensionNode {
	kind            Kind = Kind.schema_extension
	directives      ?[]DirectiveNode
	operation_types ?[]OperationTypeDefinitionNode
pub mut:
	loc ?Location
}
```

[[Return to contents]](#Contents)

## SelectionSetNode

```v
struct SelectionSetNode {
pub:
	kind       Kind = Kind.selection_set
	selections []SelectionNode
pub mut:
	loc ?Location
}
```

[[Return to contents]](#Contents)

## Source

```v
struct Source {
pub:
	body            string
	name            string
	location_offset LocationOffset
}
```

A representation of source input to GraphQL. The `name` and `locationOffset` parameters are
optional, but they are useful for clients who store GraphQL documents in source files.  
For example, if the GraphQL input starts at line 40 in a file named `Foo.graphql`, it might
be useful for `name` to be `"Foo.graphql"` and location to be `{ line: 40, column: 1 }`.  
The `line` and `column` properties in `locationOffset` are 1-indexed.

[[Return to contents]](#Contents)

## StringValueNode

```v
struct StringValueNode {
pub:
	kind     Kind = Kind.string_value
	value    ?string
	block    ?bool
	is_const bool
pub mut:
	loc ?Location
}
```

[[Return to contents]](#Contents)

## Token

```v
struct Token {
pub:
	kind TokenKind
	// The character offset at which this Node begins.
	start int
	// The character offset at which this Node ends.
	end int
	// The 1-indexed line number on which this Token appears.
	line int
	// The 1-indexed column number at which this Token begins.
	column int
	// For non-punctuation tokens, represents the interpreted value of the token.
	// <br>
	// **Note**: is `none` for punctuation tokens, but typed as string for
	// convenience in the parser.
	value ?string
mut:
	// Tokens exist as nodes in a double-linked-list amongst all tokens
	// including ignored tokens. <SOF> is always the first node and <EOF>
	// the last.
	prev ?&Token
	next ?&Token
}
```

[[Return to contents]](#Contents)

## UnionTypeDefinitionNode

```v
struct UnionTypeDefinitionNode {
	kind        Kind = Kind.union_type_definition
	description ?StringValueNode
	name        NameNode
	directives  ?[]DirectiveNode
	types       ?[]NamedTypeNode
pub mut:
	loc ?Location
}
```

[[Return to contents]](#Contents)

## UnionTypeExtensionNode

```v
struct UnionTypeExtensionNode {
	kind       Kind = Kind.union_type_extension
	name       NameNode
	directives ?[]DirectiveNode
	types      ?[]NamedTypeNode
pub mut:
	loc ?Location
}
```

[[Return to contents]](#Contents)

## VariableDefinitionNode

```v
struct VariableDefinitionNode {
pub:
	kind          Kind = Kind.variable_definition
	variable      VariableNode
	@type         TypeNode
	default_value ?ValueNode
	directives    ?[]DirectiveNode
pub mut:
	loc ?Location
}
```

[[Return to contents]](#Contents)

## VariableNode

```v
struct VariableNode {
pub:
	kind Kind = Kind.variable
	name NameNode
pub mut:
	loc ?Location
}
```

[[Return to contents]](#Contents)

## BlockStringOptions

```v
struct BlockStringOptions {
pub:
	minimize bool
}
```

[[Return to contents]](#Contents)

## BooleanValueNode

```v
struct BooleanValueNode {
pub:
	kind     Kind = Kind.boolean
	value    bool
	is_const bool
pub mut:
	loc ?Location
}
```

[[Return to contents]](#Contents)

## ConstArgumentNode

```v
struct ConstArgumentNode {
pub:
	kind  Kind = Kind.argument
	name  NameNode
	value ValueNode
pub mut:
	loc ?Location
}
```

[[Return to contents]](#Contents)

## ConstObjectFieldNode

```v
struct ConstObjectFieldNode {
pub:
	kind     Kind = Kind.object_field
	name     NameNode
	value    ValueNode
	is_const bool = true
pub mut:
	loc ?Location
}
```

[[Return to contents]](#Contents)

## ConstObjectValueNode

```v
struct ConstObjectValueNode {
pub:
	kind     Kind = Kind.object
	fields   []ValueNode
	is_const bool = true
pub mut:
	loc ?Location
}
```

[[Return to contents]](#Contents)

## DirectiveDefinitionNode

```v
struct DirectiveDefinitionNode {
	kind        Kind = Kind.directive_definition
	description ?StringValueNode
	name        NameNode
	arguments   ?[]InputValueDefinitionNode
	repeatable  bool
	locations   []NameNode
pub mut:
	loc ?Location
}
```

[[Return to contents]](#Contents)

## DirectiveNode

```v
struct DirectiveNode {
pub:
	kind      Kind = Kind.directive
	name      NameNode
	arguments ?[]ArgumentNode
pub mut:
	loc      ?Location
	is_const bool
}
```

[[Return to contents]](#Contents)

## DocumentNode

```v
struct DocumentNode {
pub:
	kind        Kind = Kind.document
	definitions []DefinitionNode
	token_count int
pub mut:
	loc ?Location
}
```

[[Return to contents]](#Contents)

## EnumTypeDefinitionNode

```v
struct EnumTypeDefinitionNode {
	kind        Kind = Kind.enum_type_definition
	description ?StringValueNode
	name        NameNode
	directives  ?[]DirectiveNode
	values      ?[]EnumValueDefinitionNode
pub mut:
	loc ?Location
}
```

[[Return to contents]](#Contents)

## EnumTypeExtensionNode

```v
struct EnumTypeExtensionNode {
	kind       Kind = Kind.enum_type_extension
	name       NameNode
	directives ?[]DirectiveNode
	values     ?[]EnumValueDefinitionNode
pub mut:
	loc ?Location
}
```

[[Return to contents]](#Contents)

## EnumValueDefinitionNode

```v
struct EnumValueDefinitionNode {
	kind        Kind = Kind.enum_value_definition
	description ?StringValueNode
	name        NameNode
	directives  ?[]DirectiveNode
pub mut:
	loc ?Location
}
```

[[Return to contents]](#Contents)

## EnumValueNode

```v
struct EnumValueNode {
pub:
	kind     Kind = Kind.enum_value
	value    string
	is_const bool
pub mut:
	loc ?Location
}
```

[[Return to contents]](#Contents)

## ErrorBoundaryNode

```v
struct ErrorBoundaryNode {
pub:
	kind                  Kind = Kind.error_boundary
	nullability_assertion ?ListNullabilityOperatorNode
pub mut:
	loc ?Location
}
```

[[Return to contents]](#Contents)

## FieldDefinitionNode

```v
struct FieldDefinitionNode {
	kind        Kind = Kind.field_definition
	description ?StringValueNode
	name        NameNode
	arguments   ?[]InputValueDefinitionNode
	@type       TypeNode
	directives  ?[]DirectiveNode
pub mut:
	loc ?Location
}
```

[[Return to contents]](#Contents)

## FieldNode

```v
struct FieldNode {
pub:
	kind                  Kind = Kind.field
	alias                 ?NameNode
	name                  NameNode
	arguments             ?[]ArgumentNode
	nullability_assertion ?NullabilityAssertionNode
	directives            []DirectiveNode
	selection_set         ?SelectionSetNode
pub mut:
	loc ?Location
}
```

[[Return to contents]](#Contents)

## FloatValueNode

```v
struct FloatValueNode {
pub:
	kind     Kind = Kind.float_value
	value    ?string
	is_const bool
pub mut:
	loc ?Location
}
```

[[Return to contents]](#Contents)

## FragmentDefinitionNode

```v
struct FragmentDefinitionNode {
pub:
	kind           Kind = Kind.fragment_definition
	name           NameNode
	type_condition NamedTypeNode
	directives     []DirectiveNode
	selection_set  SelectionSetNode
pub mut:
	loc ?Location
}
```

[[Return to contents]](#Contents)

## FragmentSpreadNode

```v
struct FragmentSpreadNode {
pub:
	kind       Kind = Kind.fragment_spread
	name       NameNode
	directives ?[]DirectiveNode
pub mut:
	loc ?Location
}
```

Fragments

[[Return to contents]](#Contents)

## InlineFragmentNode

```v
struct InlineFragmentNode {
pub:
	kind           Kind = Kind.inline_fragment
	type_condition ?NamedTypeNode
	directives     ?[]DirectiveNode
	selection_set  SelectionSetNode
pub mut:
	loc ?Location
}
```

[[Return to contents]](#Contents)

## InputObjectTypeDefinitionNode

```v
struct InputObjectTypeDefinitionNode {
	kind        Kind = Kind.input_object_type_definition
	description ?StringValueNode
	name        NameNode
	directives  ?[]DirectiveNode
	fields      ?[]InputValueDefinitionNode
pub mut:
	loc ?Location
}
```

[[Return to contents]](#Contents)

## InputObjectTypeExtensionNode

```v
struct InputObjectTypeExtensionNode {
	kind       Kind = Kind.object_type_extension
	name       NameNode
	directives ?[]DirectiveNode
	fields     ?[]InputValueDefinitionNode
pub mut:
	loc ?Location
}
```

[[Return to contents]](#Contents)

## InputValueDefinitionNode

```v
struct InputValueDefinitionNode {
	kind          Kind
	description   ?StringValueNode
	name          NameNode
	@type         TypeNode
	default_value ?ValueNode
	directives    ?[]DirectiveNode
pub mut:
	loc ?Location
}
```

[[Return to contents]](#Contents)

#### Powered by vdoc. Generated on: 17 Sep 2023 23:47:23
