import os { get_lines }

fn main() {
	inputs := get_lines()
	preamble := 25
	for i := preamble; i < inputs.len; i++ {
		if xmas(inputs[i-preamble..i], inputs[i]) == false {
			println(inputs[i])
			break
		}
	}
}

fn xmas(elements []string, number string) bool {
	// Use i64 because input has large integers causing an integer overflow
	mut sums := []i64{}
	// Clear need of optimization here, already summed values could be skipped
	for i := 0; i < elements.len; i++ {
		for j:= i+1; j < elements.len; j++ {
			sums << elements[i].i64() + elements[j].i64()
		}
	}
	if number.i64() in sums {
		return true
	}
	return false
}
