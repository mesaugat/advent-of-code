import os { get_lines }

struct Slope {
	right int
	down  int
}

fn main() {
	inputs := get_lines()
	mut forest := []string{cap: inputs.len}
	// Make the forest 100 times larger, no need to be accurate
	for i in inputs {
		forest << i.repeat(100)
	}
	mut result := 1
	mut slopes := [
		Slope{1, 1},
		Slope{3, 1},
		Slope{5, 1},
		Slope{7, 1},
		Slope{1, 2},
	]
	for slope in slopes {
		mut trees := 0
		mut cursor := slope.right
		for i := slope.down; i < forest.len; i = i + slope.down {
			checkpoint := forest[i][cursor].str()
			if checkpoint == '#' {
				trees++
			}
			cursor += slope.right
		}
		println('Trees: $trees')
		result *= trees
	}
	println('Result: $result')
}
