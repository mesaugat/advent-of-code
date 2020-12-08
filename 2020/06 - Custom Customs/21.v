import os { read_file }

fn main() {
	file := read_file('input.txt') or {
		panic(err)
	}
	inputs := file.trim_space().split('\n\n')
	mut questions := 0
	for input in inputs {
		mut m := map[string]int{}
		chars := input.replace('\n', '').split('')
		persons := input.count('\n') + 1
		for char in chars {
			if (char in m) == false {
				m[char] = 1
			} else {
				m[char]++
			}
		}
		if persons == 1 {
			questions += input.len
		}
		for _, value in m {
			if value == persons && persons != 1 {
				questions++
			}
		}
	}
	println('Result: $questions')
}
