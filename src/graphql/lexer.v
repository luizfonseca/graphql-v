module graphql

pub struct Lexer {
pub:
	source Source
mut:
	line_start int
	line       int
	last_token Token
	token      Token
}

fn Lexer.new(source Source) Lexer {
	start_of_file_token := Token.new(TokenKind.sof, 0, 0, 0, 0)

	return Lexer{
		source: source
		last_token: start_of_file_token
		token: start_of_file_token
		line: 1
		line_start: 0
	}
}

// Advances the token stream to the next non-ignored token.
fn (mut p Lexer) advance() Token {
	p.last_token = p.token
	// token := p.lookahead()
	p.token = token

	return token
}

// Looks ahead and returns the next non-ignored token,
// but does not change the state of Lexer.
// fn (mut p Lexer) lookahead() Token {
// 	mut token := p.token

// 	if token.kind != TokenKind.eof {
// 		for {
// 			match token.next {
// 				none {
// 					mut next_token := p.read_next_token(token.end)

// 					token.next = next_token
// 					next_token.prev = token
// 					token = next_token
// 				}
// 				else {
// 					ff := token.next?
// 					token = *ff
// 				}
// 			}

// 			// Exits loop
// 			if token.kind != TokenKind.comment {
// 				break
// 			}
// 		}
// 	}

// 	return token
// }

// fn (mut lexer Lexer) read_next_token(start int) Token {
// 	body := lexer.source.body

// 	mut body_length := body.len
// 	mut position := start

// 	for {
// 		if position >= body_length {
// 			break
// 		}

// 		// code := body[position]
// 		position += 1
// 		// match code {
// 		// 	// Ignored ::
// 		// 	//   - UnicodeBOM
// 		// 	//   - WhiteSpace
// 		// 	//   - LineTerminator
// 		// 	//   - Comment
// 		// 	//   - Comma
// 		// 	//
// 		// 	// UnicodeBOM :: "Byte Order Mark (U+FEFF)"
// 		// 	//
// 		// 	// WhiteSpace ::
// 		// 	//   - "Horizontal Tab (U+0009)"
// 		// 	//   - "Space (U+0020)"
// 		// 	//
// 		// 	// Comma :: ,
// 		// 	0xfeff, 0x0009, 0x0020, 0x002c {
// 		// 		position += 1
// 		// 		continue
// 		// 	}
// 		// 	// LineTerminator ::
// 		// 	//   - "New Line (U+000A)"
// 		// 	//   - "Carriage Return (U+000D)" [lookahead != "New Line (U+000A)"]
// 		// 	//   - "Carriage Return (U+000D)" "New Line (U+000A)"
// 		// 	// \n
// 		// 	0x000a {
// 		// 		position += 1
// 		// 		lexer.line += 1
// 		// 		lexer.line_start += 1
// 		// 		continue
// 		// 	}
// 		// 	// \r
// 		// 	0x000d {
// 		// 		if body[position + 1] == 0x000a {
// 		// 			position += 2
// 		// 		} else {
// 		// 			position += 1
// 		// 		}

// 		// 		lexer.line += 1
// 		// 		lexer.line_start = position
// 		// 		continue
// 		// 	}
// 		// 	// # (comment)
// 		// 	0x0023 {
// 		// 		// do nothing
// 		// 		continue
// 		// 	}
// 		// 	// Token ::
// 		// 	//   - Punctuator
// 		// 	//   - Name
// 		// 	//   - IntValue
// 		// 	//   - FloatValue
// 		// 	//   - StringValue
// 		// 	//
// 		// 	// Punctuator :: one of ! $ & ( ) ... : = @ [ ] { | }
// 		// 	0x0021 {
// 		// 		return lexer.create_token(TokenKind.bang, position, position + 1)
// 		// 	}
// 		// 	0x0024 { // $
// 		// 		return createToken(lexer, TokenKind.dollar, position, position + 1)
// 		// 	}
// 		// 	0x0026 { // &
// 		// 		return createToken(lexer, TokenKind.amp, position, position + 1)
// 		// 	}
// 		// 	0x0028 { // (
// 		// 		return createToken(lexer, TokenKind.paren_l, position, position + 1)
// 		// 	}
// 		// 	0x0029 { // )
// 		// 		return createToken(lexer, TokenKind.paren_r, position, position + 1)
// 		// 	}
// 		// 	else {
// 		// 		position += 1
// 		// 		return lexer.last_token
// 		// 	}
// 		// }
// 	}

// 	return lexer.create_token(TokenKind.eof, body_length, body_length)
// }

fn (lexer Lexer) create_token(kind TokenKind, start int, end int, value ?string) {
	line := lexer.line
	col := 1 + start - lexer.line_start

	return Token{
		kind: kind
		start: start
		end: end
		line: line
		col: col
		value: value
	}
}

fn is_punctuator_token_kind(kind TokenKind) bool {
	return match kind {
		.bang, .question_mark, .dollar, .amp, .paren_l, .paren_r, .spread, .colon, .equals, .at,
		.bracket_l, .bracket_r, .brace_l, .pipe, .brace_r {
			true
		}
		else {
			false
		}
	}
}
