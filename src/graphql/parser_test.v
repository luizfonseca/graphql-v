import graphql
import os

fn test_query_parse() {
	body := '{
        node(id: 4) {
          id,
          name
        }
	}'

	result := graphql.parse(body, none) or { panic(err) }

	assert result.kind == graphql.Kind.document
	assert result.loc?.source.body == body
}

fn test_github_parse() ! {
	path := os.real_path('./fixtures/github.graphql')

	body := os.read_file(path)!

	result := graphql.parse(body, none) or { panic(err) }

	assert result.kind == graphql.Kind.document
	assert result.token_count == 19_882
}

fn test_simple_parse() ! {
	path := os.real_path('./fixtures/simple.graphql')

	body := os.read_file(path)!

	result := graphql.parse(body, none) or { panic(err) }

	assert result.kind == graphql.Kind.document
	assert result.token_count == 175
}
