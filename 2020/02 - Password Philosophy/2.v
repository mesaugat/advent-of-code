import os { get_lines }
import regex { regex_opt }

fn main() {
	inputs := get_lines()
	mut result := 0
	// `\a` matches lowercase letters for some reason
	query := r'(\d+)-(\d+) (\a): (\a+)'
	mut re := regex_opt(query) or {
		panic(err)
	}
	for i in inputs {
		re.match_string(i)
		// As every input matches the regex pattern, no need to check for matching groups (see 1st solution)
		pos1 := i[re.groups[0]..re.groups[1]]
		pos2 := i[re.groups[2]..re.groups[3]]
		letter := i[re.groups[4]..re.groups[5]]
		password := i[re.groups[6]..re.groups[7]]
		if password[pos1.int() - 1].str() == letter && password[pos2.int() - 1].str() != letter {
			result++
		}
		if password[pos2.int() - 1].str() == letter && password[pos1.int() - 1].str() != letter {
			result++
		}
	}
	println('Result: $result')
}
