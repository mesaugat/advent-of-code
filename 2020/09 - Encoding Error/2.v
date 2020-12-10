import os { get_lines }

fn main() {
	inputs := get_lines()
	preamble := 25
	mut limit := 0
	for i := preamble; i < inputs.len; i++ {
		if xmas(inputs[i - preamble..i], inputs[i]) == false {
			limit = inputs[i].int()
			break
		}
	}
	list, sum := contiguous_sum(inputs, limit)
	// list.sort doesn't work for i64 integers?
	// what a mess, bubble sort FTW
	sorted_list := bubble_sort(list)
	result := list.first() + list.last()
	println('Limit: $limit')
	println('Sum: $sum')
	println('List: $list')
	println('Sorted List: $sorted_list')
	println('Result: $result')
}

fn xmas(elements []string, number string) bool {
	mut sums := []i64{}
	for i := 0; i < elements.len; i++ {
		for j := i + 1; j < elements.len; j++ {
			sums << elements[i].i64() + elements[j].i64()
		}
	}
	if number.i64() in sums {
		return true
	}
	return false
}

// This function is similar to xmas ... GG
fn contiguous_sum(elements []string, limit i64) ([]i64, i64) {
	mut sum := i64(0)
	mut list := []i64{}
	for i := 0; i < elements.len; i++ {
		sum = elements[i].i64()
		list = []
		list << elements[i].i64()
		for j := i + 1; j < elements.len; j++ {
			list << elements[j].i64()
			sum += elements[j].i64()
			if sum >= limit {
				break
			}
		}
		if sum == limit {
			break
		}
	}
	return list, sum
}

fn bubble_sort(items []i64) []i64 {
	mut list := items
	for i := 0; i < items.len - 1; i++ {
		for j := 0; j < items.len - i - 1; j++ {
			if list[j] > list[j + 1] {
				temp := list[j]
				list[j] = list[j + 1]
				list[j + 1] = temp
			}
		}
	}
	return list
}
