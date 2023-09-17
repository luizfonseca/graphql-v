module main

import graphql
import os

fn main() {
	path := os.real_path('./fixtures/github.graphql')

	file_content := os.read_file(path) or { panic(err) }
	println('Reading file with length ${file_content.len}')

	doc := graphql.parse(file_content, none) or { panic('Error: ${err}') }
	println('DocumentNode token count: ${doc.token_count}')
	for {
		// Watch memory
	}
}
