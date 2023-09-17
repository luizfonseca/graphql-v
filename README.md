# GraphQL for the V language

## Current state

Work in progress.

- [x] Language Parser (lexer, parser implementation)
- [x] Fixtures are covered 100% (GH, Simple)
- [ ] Integration tests
- [ ] Schema execute
- [ ] Publish to VPM
- [ ] Documentation

## Usage

### Parsing a .graphql definition file

You can parse any string/file using the `.parse` function.
It returns a [DocumentNode](./src/graphql/src.graphql.md#documentnode) with al the definitions that were parsed, in a tree structure.

```v
import graphql
import os

fn main() {
    // For files
    file := os.read_file('path-to-file.graphql')

    // For string inputs
    // input := 'query {
    // myQuery(id: 1) {
    //  name
    //  age
    // }
    //}'

    // max_tokens: number of tokens to parse.
    // Increasing this means supporting longer queries/schema definitions
    doc := graphql.parse(file, graphql.ParserOptions{ max_tokens: 25_000 })

    dump(doc.token_count)
    dump(doc.definitions)
}
```

## Links

- [The V programming language](https://vlang.io/)
- [GraphQL](https://graphql.org/)

## Notes

- This package is inspired by the work of the GraphQL.js package and as such is not yet perfected for the V lang.

## Contributing

- Feedbacks/PRs are welcome, but keep in mind this is still a **work in progress**.

## Credits

- [GraphQL](https://graphql.org/)
- [GraphQL.js](https://graphql.org/graphql-js/)

- “GraphQL” is a trademark managed by the [GraphQL Foundation](https://graphql.org/foundation/).
