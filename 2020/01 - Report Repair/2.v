import os { get_lines }

fn main() {
	input := get_lines()
	mut sum := 0
	mut result := 0
	for i := 0; i < input.len; i++ {
		for j := i + 1; j < input.len - 1; j++ {
			for k := i + 2; k < input.len - 2; k++ {
				sum = input[i].int() + input[j].int() + input[k].int()
				if sum == 2020 {
					result = input[i].int() * input[j].int() * input[k].int()
					break
				}
			}
			if sum == 2020 {
				break
			}
		}
		if sum == 2020 {
			break
		}
	}
	println('Result: $result')
}
