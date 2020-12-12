import os { get_lines }

fn main() {
	inputs := get_lines()
	mut int_inputs := []int{}
	int_inputs << 0
	for input in inputs {
		int_inputs << input.int()
	}
	int_inputs.sort()
	int_inputs << int_inputs.last() + 3
	mut cache := []i64{len: int_inputs.len, init: -1}
	count := count_arrangements(0, int_inputs, mut cache)
	println('Result: $count')
}

// Recursion with memoization equals dynamic programming
fn count_arrangements(index int, inputs []int, mut cache []i64) i64 {
	if index == inputs.len - 1 {
		return 1
	}
	if index in cache && cache[index] != -1 {
		return cache[index]
	}
	mut count := i64(0)
	for j := index + 1; j < inputs.len; j++ {
		if (inputs[j] - inputs[index]) <= 3 {
			count += count_arrangements(j, inputs, mut cache)
		}
	}
	// I wasted an hour here because I didn't initialize the array size
	// I thought index out of range was coming from somewhere else in the code
	// V panic: array.set: index out of range (i == 11, a.len == 0)
	// https://github.com/vlang/v/blob/master/doc/docs.md#initializing-array-properties
	cache[index] = count
	return count
}
