import os { get_lines }
import regex { regex_opt }

fn main() {
	inputs := get_lines()
	mut pos1 := ''
	mut pos2 := ''
	mut letter := ''
	mut password := ''
	mut result := 0
	// `\a` matches lowercase letters for some reason
	query := r'(\d+)-(\d+) (\a): (\a+)'
	mut re := regex_opt(query) or {
		panic(err)
	}
	for i in inputs {
		// The match starts at the 0th index and ends at the 5th index
		// The output of match_string is thus 0, 5
		re.match_string(i)
		// re.groups.len will be 8 because there are 4 capture groups and
		// each index in re.groups []int will have the capture groups
		// starting and ending index.
		//
		// Well, regex was a bad idea. Even re.group_csave didn't make
		// a lot of sense.
		// @see https://modules.vlang.io/regex.html
		if re.groups[0] > -1 {
			pos1 = i[re.groups[0]..re.groups[1]]
		}
		if re.groups[2] > -1 {
			pos2 = i[re.groups[2]..re.groups[3]]
		}
		if re.groups[4] > -1 {
			letter = i[re.groups[4]..re.groups[5]]
		}
		if re.groups[6] > -1 {
			password = i[re.groups[6]..re.groups[7]]
		}
		if password[pos1.int() - 1].str() == letter && password[pos2.int() - 1].str() != letter {
			result++
		}
		if password[pos2.int() - 1].str() == letter && password[pos1.int() - 1].str() != letter {
			result++
		}
	}
	println('Result: $result')
}
