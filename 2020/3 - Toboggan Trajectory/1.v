import os { get_lines }

fn main() {
	inputs := get_lines()
	mut forest := []string{cap: inputs.len}
	// Make the forest 100 times larger, no need to be accurate
	for i in inputs {
		forest << i.repeat(100)
	}
	mut result := 0
	mut cursor := 3
	for i := 1; i < forest.len; i++ {
		checkpoint := forest[i][cursor].str()
		if checkpoint == '#' {
			result++
		}
		cursor += 3
	}
	println('Result: $result')
}
