import os { get_lines }

struct Slope {
	rowstep int
	colstep int
}

// Better solution for 1 and 2
fn main() {
	inputs := get_lines()
	slopes := [
		Slope{1, 1},
		Slope{1, 3},
		Slope{1, 5},
		Slope{1, 7},
		Slope{2, 1},
	]
	mut result := 1
	for slope in slopes {
		total_rows := inputs.len
		total_cols := inputs[0].len
		mut row := 0
		mut col := 0
		mut trees := 0
		for row < total_rows {
			row += slope.rowstep
			col += slope.colstep
			if row >= total_rows {
				break
			}
			if inputs[row][col % total_cols].str() == '#' {
				trees++
			}
		}
		result *= trees
	}
	print('Result: $result')
}
