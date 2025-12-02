def parse_range(str)
  str.split('-').map(&:to_i)
end

def parse_input(str)
  str.split(',').map { |range| parse_range(range) }
end

def invalid_id_part1?(str)
  return false if str.length.odd?

  chars = str.chars
  first_half = chars[0...(chars.length / 2)]
  second_half = chars[(chars.length / 2)...chars.length]

  first_half == second_half
end

def factors(n)
  (1..n).select { |i| n % i == 0 }
end

def invalid_id_part2?(str)
  return false if str.length <= 1

  chars = str.chars
  factors = factors(chars.length) - [chars.length]

  factors.each do |factor|
    return true if chars.each_slice(factor).to_a.uniq.length == 1
  end

  false
end

ranges = parse_input(File.read("./input.txt"))
invalid_ids_part1 = []
invalid_ids_part2 = []

ranges.each do |range|
  (range[0]..range[1]).each do |n|
    invalid_ids_part1 << n if invalid_id_part1?(n.to_s)
    invalid_ids_part2 << n if invalid_id_part2?(n.to_s)
  end
end

puts "Sum of invalid IDs part 1: #{invalid_ids_part1.sum}"
puts "Sum of invalid IDs part 2: #{invalid_ids_part2.sum}"