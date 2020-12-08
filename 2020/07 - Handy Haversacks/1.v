import os { get_lines }

// Looks like a tree but I don't remember how any tree data structures work ¯\_(ツ)_/¯
fn main() {
	inputs := get_lines()
	mut count := 0
	mut m := map[string][]string{}
	// Intentionally not using regex to parse the input
	for input in inputs {
		n := input.all_before('s contain')
		o := input.all_after('contain ').replace('.', '').replace('bags', 'bag').split(',')
		mut r := []string{}
		for p in o {
			q := p.trim_space().split(' ')
			if q.len == 4 {
				r << q[1..4].join(' ')
			} else if q.len == 3 {
				r << q[0..3].join(' ')
			}
		}
		m[n] = r
	}
	for color, _ in m {
		if check_bag(color, m) == true && color != 'shiny gold bag' {
			count++
		}
	}
	println('Result: $count')
}

// A bag which has already been visited could be memoized
fn check_bag(color string, m map[string][]string) bool {
	if color == 'shiny gold bag' {
		return true
	}
	if (color in m) == false {
		return false
	}
	// Inner bags
	for bag in m[color] {
		if check_bag(bag, m) == true {
			return true
		}
	}
	return false
}
