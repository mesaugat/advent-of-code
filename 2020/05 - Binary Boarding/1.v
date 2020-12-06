import os { get_lines }
import math { max }

fn main() {
	inputs := get_lines()
	mut num := 0.0
	for input in inputs {
		region := input[0..7]
		seat := input[7..10]
		row := partition(0, 127, 0, region)
		col := partition(0, 7, 0, seat)
		result := row * 8 + col
		num = max(result, num)
	}
	println('Result: $num')
}

fn partition(start int, end int, index int, text string) int {
	half := (start + end) / 2
	diff := end - start
	is_lower_half := text[index].str() == 'F' || text[index].str() == 'L'
	is_upper_half := text[index].str() == 'B' || text[index].str() == 'R'
	if diff <= 1 {
		if is_lower_half {
			return start
		} else {
			return end
		}
	}
	if is_lower_half {
		return partition(start, half, index + 1, text)
	} else if is_upper_half {
		return partition(half + 1, end, index + 1, text)
	}
	return 0
}
