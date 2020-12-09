import os { get_lines }

fn main() {
	inputs := get_lines()
	mut i := 0
	mut acc := 0
	mut visited := []int{}
	for {
		instructions := inputs[i].split(' ')
		operation := instructions[0]
		argument := instructions[1].int()
		if (i in visited) == true {
			println('Result: $acc')
			break
		}
		visited << i
		if operation == 'nop' {
			i++
		} else if operation == 'acc' {
			i++
			acc += argument
		} else if operation == 'jmp' {
			i += argument
		}
	}
}
