def parse_ranges(ranges_input)
  ranges_input.map do |range_input|
    (min, max) = range_input.split('-').map(&:to_i)
    min..max
  end
end

def count_fresh_ingredients(filename)
  input = File.readlines(filename).map(&:chomp)
  divider_idx = input.index('')

  fresh_ingredient_ranges = parse_ranges(input[0...divider_idx])

  num_fresh = 0

  input[(divider_idx + 1)...-1].map(&:to_i).each do |ingredient|
    num_fresh += 1 if fresh_ingredient_ranges.any? { |range| range.include?(ingredient) }
  end

  num_fresh
end

puts "=== Part 1 ==="
puts "Example solution: #{count_fresh_ingredients('./example_input.txt')}"
puts "Solution: #{count_fresh_ingredients('./input.txt')}"