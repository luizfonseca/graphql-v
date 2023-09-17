module main

import graphql
// import os
import os

fn main() {
	// println('Hello World!')
	path := os.real_path('./fixtures/github.graphql')

	// body := '{
	//     node(id: 4) {
	//       id,
	//       name
	//     }
	// }'

	file_content := os.read_file(path) or { panic(err) }
	result := graphql.parse(file_content, none) or { panic('Error: ${err}') }
	// println(result.token_count)
	for {
		// println('running')
		break
	}
}

fn result_function() !string {
	return error('Error')
}
