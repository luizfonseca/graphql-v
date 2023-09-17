module main

import graphql
// import os
import os

fn main() {
	println('Hello World!')
	path := os.real_path('./fixtures/github.graphql')

	body := '{
        node(id: 4) {
          id,
          name
        }
	}'

	file_content := os.read_file(path) or { panic(err) }

	parsed := graphql.parse(file_content, graphql.ParserOptions{
		max_tokens: 1_000_000
	}) or { panic('Error ${err}') }

	// println(parsed)
}

fn result_function() !string {
	return error('Error')
}
