import os { get_lines }
import regex { regex_opt }

fn main() {
	inputs := get_lines()
	mut min := ''
	mut max := ''
	mut letter := ''
	mut password := ''
	mut result := 0
	// `\a` matches lowercase letters for some reason
	query := r'(\d+)-(\d+) (\a): (\a+)'
	mut re := regex_opt(query) or {
		panic(err)
	}
	for i in inputs {
		re.match_string(i)
		// re.groups.len will be 8 because there are 4 capture groups and
		// each index in re.groups []int will have the capture groups
		// starting and ending index.
		//
		// Well, regex was a bad idea. Even re.group_csave didn't make
		// a lot of sense.
		// @see https://modules.vlang.io/regex.html
		if re.groups[0] > -1 {
			min = i[re.groups[0]..re.groups[1]]
		}
		if re.groups[2] > -1 {
			max = i[re.groups[2]..re.groups[3]]
		}
		if re.groups[4] > -1 {
			letter = i[re.groups[4]..re.groups[5]]
		}
		if re.groups[6] > -1 {
			password = i[re.groups[6]..re.groups[7]]
		}
		// string.count --> counts occurences of substr in s
		if password.count(letter) >= min.int() && password.count(letter) <= max.int() {
			result++
		}
	}
	println('Result: $result')
}
