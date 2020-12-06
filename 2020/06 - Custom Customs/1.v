import os { read_file }

fn main() {
	file := read_file('input.txt') or {
		panic(err)
	}
	inputs := file.trim_space().split('\n\n')
	mut questions := 0
	mut groups := []map[string]int{}
	for input in inputs {
		mut m := map[string]int{}
		chars := input.replace('\n', '').split('')
		for char in chars {
			// Don't need to count the repeated questions but I'm
			// trying to predict the follow up question here.
			if (char in m) == false {
				m[char] = 1
			} else {
				m[char]++
			}
		}
		groups << m
		questions += m.len
	}
	println('Result: $questions')
}
