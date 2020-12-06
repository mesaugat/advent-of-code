import os { read_file }
import regex { regex_opt }

fn main() {
	file := read_file('input.txt') or {
		panic(err)
	}
	passports := file.trim_space().split('\n\n')
	authentic_list := filter_authentic_passports(passports)
	count := count_valid_passwords(authentic_list)
	println('Result: $count')
}

// Why am I doing this at midnight?
fn count_valid_passwords(items [][]string) int {
	mut fields := map[string]string{}
	mut count := 0
	for item in items {
		for i := 0; i < item.len; i += 2 {
			fields[item[i]] = item[i + 1]
		}
		// byr
		if fields['byr'].int() < 1920 || fields['byr'].int() > 2002 {
			continue
		}
		// iyr
		if fields['iyr'].int() < 2010 || fields['iyr'].int() > 2020 {
			continue
		}
		// eyr
		if fields['eyr'].int() < 2020 || fields['eyr'].int() > 2030 {
			continue
		}
		// ecl
		if !(fields['ecl'] in ['amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth']) {
			continue
		}
		if fields['pid'].len != 9 {
			continue
		}
		// hcl
		hcl_regex := r'#[0-9a-f]{6}'
		mut re1 := regex_opt(hcl_regex) or {
			panic(err)
		}
		hcl_match_start, _ := re1.match_string(fields['hcl'])
		if hcl_match_start == -1 {
			continue
		}
		// hgt
		// r'(\d+)(in|cm)' didn't work. Probably a vlang issue. Wasted!
		// Missed this check and had a one-off error which took years to figure out.
		if !fields['hgt'].ends_with('cm') && !fields['hgt'].ends_with('in') {
			continue
		}
		if fields['hgt'].ends_with('cm') {
			cm := fields['hgt'].all_before('cm').int()
			if cm < 150 || cm > 193 {
				continue
			}
		}
		if fields['hgt'].ends_with('in') {
			inch := fields['hgt'].all_before('in').int()
			if inch < 59 || inch > 76 {
				continue
			}
		}
		count++
	}
	return count
}

// Filter authentic passwords which have the required fields (Solution 1)
fn filter_authentic_passports(passports []string) [][]string {
	mut authentic_list := [][]string{}
	required_fields := ['byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid']
	for passport in passports {
		items := passport.replace(' ', ':').replace('\n', ':').split(':')
		scans := intersect(required_fields, items)
		if scans.len >= 7 {
			authentic_list << items
		}
	}
	return authentic_list
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
