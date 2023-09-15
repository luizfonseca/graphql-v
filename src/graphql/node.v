module graphql

pub struct NameNode {
pub:
	kind  Kind = Kind.name
	value string
pub mut:
	loc ?Location
}

pub struct DocumentNode {
pub:
	kind        Kind = Kind.document
	definitions []DefinitionNode
pub mut:
	loc ?Location
}

pub type TypeSystemExtensionNode = SchemaExtensionNode | TypeExtensionNode

pub type DefinitionNode = DirectiveDefinitionNode
	| ExecutableDefinitionNode
	| OperationDefinitionNode
	| SchemaDefinitionNode
	| SchemaExtensionNode
	| TypeDefinitionNode
	| TypeExtensionNode
pub type ExecutableDefinitionNode = FragmentDefinitionNode | OperationDefinitionNode

pub struct OperationDefinitionNode {
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

pub enum OperationTypeNode {
	query
	mutation
	subscription
}

pub fn (o OperationTypeNode) gql_str() string {
	return o.str()
}

pub struct VariableDefinitionNode {
pub:
	kind          Kind = Kind.variable_definition
	variable      VariableNode
	@type         TypeNode
	default_value ?ConstValueNode
	directives    ?[]ConstDirectiveNode
pub mut:
	loc ?Location
}

pub struct VariableNode {
pub:
	kind Kind = Kind.variable
	name NameNode
pub mut:
	loc ?Location
}

pub struct SelectionSetNode {
pub:
	kind       Kind = Kind.selection_set
	selections []SelectionNode
pub mut:
	loc ?Location
}

pub type SelectionNode = FieldNode | FragmentSpreadNode | InlineFragmentNode

pub struct FieldNode {
pub:
	kind                  Kind = Kind.field
	loc                   ?Location
	alias                 ?NameNode
	name                  NameNode
	arguments             ?[]ArgumentNode
	nullability_assertion ?NullabilityAssertionNode
	directives            []DirectiveNode
	selection_set         ?SelectionSetNode
}

pub type NullabilityAssertionNode = ErrorBoundaryNode
	| ListNullabilityOperatorNode
	| NonNullAssertionNode

pub struct ListNullabilityOperatorNode {
pub:
	kind                  Kind = Kind.list_nullability_operator
	nullability_assertion ?NullabilityAssertionNode
pub mut:
	loc ?Location
}

pub struct NonNullAssertionNode {
pub:
	kind                  Kind = Kind.non_null_assertion
	nullability_assertion ?ListNullabilityOperatorNode
pub mut:
	loc ?Location
}

pub struct ErrorBoundaryNode {
pub:
	kind                  Kind = Kind.error_boundary
	nullability_assertion ?ListNullabilityOperatorNode
pub mut:
	loc ?Location
}

// Values

// --
pub type ValueNode = BooleanValueNode
	| EnumValueNode
	| FloatValueNode
	| IntValueNode
	| ListValueNode
	| NullValueNode
	| ObjectValueNode
	| StringValueNode
	| VariableNode

struct ArgumentNode {
pub:
	kind  Kind = Kind.argument
	name  NameNode
	value ValueNode
pub mut:
	loc ?Location
}

pub type ConstValueNode = BooleanValueNode
	| ConstListValueNode
	| ConstObjectValueNode
	| EnumValueNode
	| FloatValueNode
	| IntValueNode
	| NullValueNode
	| StringValueNode

pub struct ConstArgumentNode {
pub:
	kind  Kind = Kind.argument
	name  NameNode
	value ValueNode
pub mut:
	loc ?Location
}

// Fragments
pub struct FragmentSpreadNode {
pub:
	kind       Kind = Kind.fragment_spread
	name       NameNode
	directives ?[]string
pub mut:
	loc ?Location
}

pub struct InlineFragmentNode {
pub:
	kind           Kind = Kind.inline_fragment
	type_condition ?NamedTypeNode
	directives     ?[]string
	selection_set  SelectionSetNode
pub mut:
	loc ?Location
}

pub struct FragmentDefinitionNode {
pub:
	kind           Kind = Kind.fragment_definition
	name           NameNode
	type_condition NamedTypeNode
	directives     []string
	selection_set  SelectionSetNode
pub mut:
	loc ?Location
}

pub struct IntValueNode {
pub:
	kind  Kind = Kind.int_value
	value ?string
pub mut:
	loc ?Location
}

pub struct FloatValueNode {
pub:
	kind  Kind = Kind.float_value
	value ?string
pub mut:
	loc ?Location
}

pub struct StringValueNode {
pub:
	kind  Kind = Kind.string_value
	value ?string
	block ?bool
pub mut:
	loc ?Location
}

pub struct BooleanValueNode {
pub:
	kind  Kind = Kind.boolean
	value bool
pub mut:
	loc ?Location
}

pub struct NullValueNode {
pub:
	kind Kind = Kind.null
pub mut:
	loc ?Location
}

pub struct EnumValueNode {
pub:
	kind  Kind = Kind.enum_value
	value string
pub mut:
	loc ?Location
}

pub struct ListValueNode {
pub:
	kind   Kind = Kind.list
	values []ValueNode
pub mut:
	loc ?Location
}

pub struct ConstListValueNode {
pub:
	kind  Kind = Kind.list
	value []ConstValueNode
pub mut:
	loc ?Location
}

pub struct ObjectValueNode {
pub:
	kind   Kind = Kind.object
	fields []ObjectFieldNode
pub mut:
	loc ?Location
}

pub struct ConstObjectValueNode {
pub:
	kind   Kind = Kind.object
	fields []ConstListValueNode
pub mut:
	loc ?Location
}

pub struct ObjectFieldNode {
pub:
	kind  Kind = Kind.object_field
	name  NameNode
	value ValueNode
pub mut:
	loc ?Location
}

pub struct ConstObjectFieldNode {
pub:
	kind  Kind = Kind.object_field
	name  NameNode
	value ConstValueNode
pub mut:
	loc ?Location
}

// Directives

pub struct DirectiveNode {
pub:
	kind      Kind = Kind.directive
	name      NameNode
	arguments ?[]ArgumentNode
pub mut:
	loc ?Location
}

pub struct ConstDirectiveNode {
pub:
	kind      Kind = Kind.directive
	name      NameNode
	arguments ?[]ConstArgumentNode
pub mut:
	loc ?Location
}

// Type reference

pub type TypeNode = ListTypeNode | NamedTypeNode | NonNullAssertionNode
pub type NonNullType = ListTypeNode | NamedTypeNode

pub struct NamedTypeNode {
pub:
	kind Kind = Kind.named_type
	name NameNode
pub mut:
	loc ?Location
}

pub struct ListTypeNode {
pub:
	kind Kind = Kind.list_type
	name TypeNode
pub mut:
	loc ?Location
}

pub struct NonNullTypeNode {
pub:
	kind Kind = Kind.non_null_type
	name NonNullType
pub mut:
	loc ?Location
}

// Type system definition

pub type TypeSystemDefinitionNode = DirectiveDefinitionNode
	| SchemaDefinitionNode
	| TypeDefinitionNode

pub struct SchemaDefinitionNode {
pub:
	kind            Kind = Kind.schema_definition
	description     ?StringValueNode
	directives      ?[]ConstDirectiveNode
	operation_types []OperationTypeDefinitionNode
pub mut:
	loc ?Location
}

pub struct OperationTypeDefinitionNode {
pub:
	kind      Kind = Kind.operation_type_definition
	operation OperationTypeNode
	@type     NamedTypeNode
pub mut:
	loc ?Location
}

// Type definition

pub type TypeDefinitionNode = EnumTypeDefinitionNode
	| InputObjectTypeDefinitionNode
	| InterfaceTypeDefinitionNode
	| ObjectTypeDefinitionNode
	| ScalarTypeDefinitionNode
	| UnionTypeDefinitionNode

pub struct ScalarTypeDefinitionNode {
	kind        Kind
	description ?StringValueNode
	name        NameNode
	directives  ?[]ConstDirectiveNode
pub mut:
	loc ?Location
}

pub struct ObjectTypeDefinitionNode {
	kind        Kind
	description ?StringValueNode
	name        NameNode
	interfaces  ?[]NamedTypeNode
	directives  ?[]ConstDirectiveNode
	fields      ?[]FieldDefinitionNode
pub mut:
	loc ?Location
}

pub struct FieldDefinitionNode {
	kind        Kind = Kind.field_definition
	description ?StringValueNode
	name        NameNode
	arguments   ?[]InputValueDefinitionNode
	@type       TypeNode
	directives  ?[]ConstDirectiveNode
pub mut:
	loc ?Location
}

pub struct InputValueDefinitionNode {
	kind          Kind
	description   ?StringValueNode
	name          NameNode
	@type         TypeNode
	default_value ?ConstValueNode
	directives    ?[]ConstDirectiveNode
pub mut:
	loc ?Location
}

pub struct InterfaceTypeDefinitionNode {
	kind        Kind = Kind.interface_type_definition
	description ?StringValueNode
	name        NameNode
	interfaces  ?[]NamedTypeNode
	directives  ?[]ConstDirectiveNode
	fields      ?[]FieldDefinitionNode
pub mut:
	loc ?Location
}

pub struct UnionTypeDefinitionNode {
	kind        Kind = Kind.union_type_definition
	description ?StringValueNode
	name        NameNode
	directives  ?[]ConstDirectiveNode
	types       ?[]NamedTypeNode
pub mut:
	loc ?Location
}

pub struct EnumTypeDefinitionNode {
	kind        Kind = Kind.enum_type_definition
	description ?StringValueNode
	name        NameNode
	directives  ?[]ConstDirectiveNode
	values      ?[]EnumValueDefinitionNode
pub mut:
	loc ?Location
}

pub struct EnumValueDefinitionNode {
	kind        Kind = Kind.enum_value_definition
	description ?StringValueNode
	name        NameNode
	directives  ?[]ConstDirectiveNode
pub mut:
	loc ?Location
}

pub struct InputObjectTypeDefinitionNode {
	kind        Kind = Kind.input_object_type_definition
	description ?StringValueNode
	name        NameNode
	directives  ?[]ConstDirectiveNode
	fields      ?[]InputValueDefinitionNode
pub mut:
	loc ?Location
}

pub struct DirectiveDefinitionNode {
	kind        Kind = Kind.directive_definition
	description ?StringValueNode
	name        NameNode
	arguments   ?[]InputValueDefinitionNode
	repeatable  bool
	locations   []NameNode
pub mut:
	loc ?Location
}

pub struct SchemaExtensionNode {
	kind            Kind = Kind.schema_extension
	directives      ?[]ConstDirectiveNode
	operation_types ?[]OperationTypeDefinitionNode
pub mut:
	loc ?Location
}

// Type Extensions

pub type TypeExtensionNode = EnumTypeExtensionNode
	| InputObjectTypeExtensionNode
	| InterfaceTypeExtensionNode
	| ObjectTypeExtensionNode
	| ScalarTypeExtensionNode
	| UnionTypeExtensionNode

pub struct ScalarTypeExtensionNode {
	kind       Kind = Kind.scalar_type_extension
	name       NameNode
	directives ?[]ConstDirectiveNode
pub mut:
	loc ?Location
}

pub struct ObjectTypeExtensionNode {
	kind       Kind = Kind.object_type_extension
	name       NameNode
	interfaces ?[]NamedTypeNode
	directives ?[]ConstDirectiveNode
	fields     ?[]FieldDefinitionNode
pub mut:
	loc ?Location
}

pub struct InterfaceTypeExtensionNode {
	kind       Kind = Kind.interface_type_extension
	name       NameNode
	interfaces ?[]NamedTypeNode
	directives ?[]ConstDirectiveNode
	fields     ?[]FieldDefinitionNode
pub mut:
	loc ?Location
}

pub struct UnionTypeExtensionNode {
	kind       Kind = Kind.union_type_extension
	name       NameNode
	directives ?[]ConstDirectiveNode
	types      ?[]NamedTypeNode
pub mut:
	loc ?Location
}

pub struct EnumTypeExtensionNode {
	kind       Kind = Kind.enum_type_extension
	name       NameNode
	directives ?[]ConstDirectiveNode
	values     ?[]EnumValueDefinitionNode
pub mut:
	loc ?Location
}

pub struct InputObjectTypeExtensionNode {
	kind       Kind = Kind.object_type_extension
	name       NameNode
	directives ?[]ConstDirectiveNode
	fields     ?[]InputValueDefinitionNode
pub mut:
	loc ?Location
}
