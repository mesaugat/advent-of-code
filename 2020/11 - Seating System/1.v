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
		for i := 0; i < rows; i++ {
			for j := 0; j < cols; j++ {
				mut occupied_count := 0
				// Adjacent seats
				for k in [-1, 0, 1] {
					for l in [-1, 0, 1] {
						// I was doing k == 0 && j == 0 instead of l == 0 and everything
						// was a little off
						// Please name your variables correctly
						if k == 0 && l == 0 {
							continue
						}
						m := i + k
						n := j + l
						// Check adjancent seats
						if ((0 <= m) && (m < rows) && (0 <= n) && (n < cols)) == true {
							if layout[m][n] == '#' {
								occupied_count++
							}
						}
					}
				}
				if layout[i][j] == 'L' && occupied_count == 0 {
					new_layout[i][j] = '#'
					changed = true
				}
				if layout[i][j] == '#' && occupied_count >= 4 {
					new_layout[i][j] = 'L'
					changed = true
				}
			}
		}
		// Simultaneously change the layout
		// I made a huge mistake here by assigning layout = new_layout
		// What this did was it started referencing new_layout and
		// new_layout started changing for every iteration which
		// was being referenced by layout.
		//
		// The solution: Clone the new_layout before setting
		// it as the layout.
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
