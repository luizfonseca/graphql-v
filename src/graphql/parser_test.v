module graphql

[assert_continues]
fn test_parse() {
	body := '{
        node(id: 4) {
          id,
          name
        }
	}'

	result := parse(body, ParserOptions{}) or { panic(err) }

	assert result.kind == Kind.document
	assert result.loc?.source.body == body
}
