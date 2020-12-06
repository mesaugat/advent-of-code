import os { read_file }

fn main() {
	file := read_file('input.txt') or {
		panic(err)
	}
	inputs := file.trim_space().split('\n\n')
	mut questions := 0
	for input in inputs {
		chars := input.split('\n\n')
		for text in chars {
			if text.count('\n') < 1 {
				// For 1 person
				questions += text.len
			} else {
				// For multiple persons
				// At this point I can't name the variables properly
				// I don't know why I want to do a set intersect every time
				k := text.split('\n')
				mut i := k[0].split('')
				for t in k {
					j := t.split('')
					i = intersect(j, i)
				}
				questions += i.len
			}
		}
	}
	println('Result: $questions')
}

// Intersection between two arrays
// Remember day 4?
fn intersect(a []string, b []string) []string {
	mut m := map[string]bool{}
	mut i := []string{}
	for value in a {
		m[value] = true
	}
	for value in b {
		if m[value] == true {
			i << value
		}
	}
	return i
}
