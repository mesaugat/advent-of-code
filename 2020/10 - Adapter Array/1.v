import os { get_lines }

struct Adapter {
	rating int
	diff   int
}

fn main() {
	inputs := get_lines()
	mut adapters := []Adapter{}
	mut int_inputs := []int{}
	int_inputs << 0
	for input in inputs {
		int_inputs << input.int()
	}
	int_inputs.sort()
	for i, input in int_inputs {
		if i + 1 == int_inputs.len {
			break
		}
		diff := int_inputs[i + 1] - input
		adapters << Adapter{int_inputs[i + 1], diff}
	}
	mut sum_1 := 0
	mut sum_3 := 0
	for adapter in adapters {
		if adapter.diff == 1 {
			sum_1++
		}
		if adapter.diff == 3 {
			sum_3++
		}
	}
	// your device's built-in adapter is always 3 higher than the highest adapter
	sum_3++
	result := sum_1 * sum_3
	println('Sum_1: $sum_1')
	println('Sum_3: $sum_3')
	println('Result: $result')
}
