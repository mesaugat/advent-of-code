import os { get_lines }

fn main() {
	mut inputs := get_lines()
	mut layout := [][]string{}
	for input in inputs {
		layout << [input.trim_space().split('')]
	}
	mut new_layout := layout.clone()
	rows := layout.len
	cols := layout[0].len
	for {
		mut changed := false
		for r := 0; r < rows; r++ {
			for c := 0; c < cols; c++ {
				mut occupied_count := 0
				for dr in [-1, 0, 1] {
					for dc in [-1, 0, 1] {
						if dr == 0 && dc == 0 {
							continue
						}
						mut m := r + dr
						mut n := c + dc
						// Part 2 addition
						// Mind block, had to look it up, pretty neat solution BTW
						// https://www.youtube.com/watch?v=d25r5GZa4us
						for ((0 <= m) &&
							(m < rows) && (0 <= n) && (n < cols) ==
							true) &&
							layout[m][n] == '.' {
							m += dr
							n += dc
						}
						if ((0 <= m) && (m < rows) && (0 <= n) && (n < cols)) == true {
							if layout[m][n] == '#' {
								occupied_count++
							}
						}
					}
				}
				if layout[r][c] == 'L' && occupied_count == 0 {
					new_layout[r][c] = '#'
					changed = true
				}
				// Part 2 condition changes from 4 to 5
				if layout[r][c] == '#' && occupied_count >= 5 {
					new_layout[r][c] = 'L'
					changed = true
				}
			}
		}
		layout = new_layout.clone()
		if changed == false {
			break
		}
	}
	// Output
	mut count := 0
	for i := 0; i < rows; i++ {
		for j := 0; j < cols; j++ {
			if layout[i][j] == '#' {
				count++
			}
		}
	}
	println('Result: $count')
}
