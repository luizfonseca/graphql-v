module main

import graphql
import os

fn main() {
	println('Hello World!')
	path := os.real_path('./fixtures/github.graphql')

	file_content := os.read_file(path) or { panic(err) }

	parsed := graphql.parse(file_content, graphql.ParserOptions{
		max_tokens: 8000
	})!

	dump(parsed)
	// for {
	// 	// println(result)
	// }
}

fn result_function() !string {
	return error('Error')
}
