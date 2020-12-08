import os { get_lines }

fn main() {
	inputs := get_lines()
	mut m := map[string][]string{}
	// Intentionally not using regex to parse the input
	for input in inputs {
		n := input.all_before('s contain')
		o := input.all_after('contain ').replace('.', '').replace('bags', 'bag').split(',')
		mut r := []string{}
		for p in o {
			r << p.trim_space()
		}
		m[n] = r
	}
	// There was actually no need to pass the number if I wasn't lazy while creating the map
	count := count_bag('1 shiny gold bag', m)
	println('Result: $count')
}

fn count_bag(color string, m map[string][]string) int {
	mut count := 0
	b := color.split(' ')[1..4].join(' ')
	for bag in m[b] {
		if bag != 'no other bag' {
			n := bag.split(' ')[0].int()
			count += n + n * count_bag(bag, m)
		}
	}
	return count
}
