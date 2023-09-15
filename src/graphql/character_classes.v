module graphql

/**
 * ```
 * WhiteSpace ::
 *   - "Horizontal Tab (U+0009)"
 *   - "Space (U+0020)"
 * ```
 * @internal
*/
fn is_white_space(code int) bool {
	return code == 0x0009 || code == 0x0020
}

/**
 * ```
 * Digit :: one of
 *   - `0` `1` `2` `3` `4` `5` `6` `7` `8` `9`
 * ```
 * @internal
*/
fn is_digit(code int) bool {
	return code >= 0x0030 && code <= 0x0039
}

/**
 * ```
 * Letter :: one of
 *   - `A` `B` `C` `D` `E` `F` `G` `H` `I` `J` `K` `L` `M`
 *   - `N` `O` `P` `Q` `R` `S` `T` `U` `V` `W` `X` `Y` `Z`
 *   - `a` `b` `c` `d` `e` `f` `g` `h` `i` `j` `k` `l` `m`
 *   - `n` `o` `p` `q` `r` `s` `t` `u` `v` `w` `x` `y` `z`
 * ```
 * @internal
*/
fn is_letter(code int) bool {
	return (code >= 0x0061 && code <= 0x007a) || (code >= 0x0041 && code <= 0x005a)
}

/**
 * ```
 * NameStart ::
 *   - Letter
 *   - `_`
 * ```
 * @internal
*/
fn is_name_start(code int) bool {
	return is_letter(code) || code == 0x005f
}

/**
 * ```
 * NameContinue ::
 *   - Letter
 *   - Digit
 *   - `_`
 * ```
 * @internal
*/
fn is_name_continue(code int) bool {
	return is_letter(code) || is_digit(code) || code == 0x005f
}
