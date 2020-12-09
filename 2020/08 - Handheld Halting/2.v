import os { get_lines }

fn main() {
	inputs := get_lines()
	for index, input in inputs {
		i := input.split(' ')
		op := i[0]
		ag := i[1]
		if op == 'nop' || op == 'jmp' {
			mut instructions := inputs.clone()
			if op == 'nop' {
				new_op := 'jmp ' + ag
				instructions[index] = new_op
			}
			if op == 'jmp' {
				new_op := 'nop ' + ag
				instructions[index] = new_op
			}
			acc, loop := run(instructions)
			if loop == false {
				println('Result: $acc')
			}
		}
	}
}

fn run(instructions []string) (int, bool) {
	mut i := 0
	mut acc := 0
	mut visited := []int{}
	mut loop := false
	for i < instructions.len {
		ins := instructions[i].split(' ')
		operation := ins[0]
		argument := ins[1].int()
		if (i in visited) == true {
			loop = true
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
	return acc, loop
}
