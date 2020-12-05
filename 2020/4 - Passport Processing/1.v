import os { read_file }

fn main() {
	file := read_file('input.txt') or {
		panic(err)
	}
	mut count := 0
	passports := file.trim_space().split('\n\n')
	required_fields := ['byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid']
	for passport in passports {
		items := passport.replace(' ', ':').replace('\n', ':').split(':')
		scans := intersect(required_fields, items)
		if scans.len >= 7 {
			count++
		}
	}
	println('Result: $count')
}

// Intersection between two arrays
fn intersect(a []string, b []string) []string {
	mut m := map[string]bool{}
	mut i := []string{}
	for value in a {
		m[value] = true
	}
	for value in b {
		if m[value] == true {
			i << value
		}
	}
	return i
}
