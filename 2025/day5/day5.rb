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

  input[(divider_idx + 1)..-1].map(&:to_i).each do |ingredient|
    num_fresh += 1 if fresh_ingredient_ranges.any? { |range| range.include?(ingredient) }
  end

  num_fresh
end

def combine_ranges(range_1, range_2)
  raise "Ranges do not overlap" unless range_1.overlap?(range_2)

  ([range_1.first, range_2.first].min..[range_1.last, range_2.last].max)
end

def count_unique_fresh_ingredients(filename)
  input = File.readlines(filename).map(&:chomp)
  divider_idx = input.index('')
  fresh_ingredient_ranges = parse_ranges(input[0...divider_idx])

  deduped_ranges = []

  fresh_ingredient_ranges.each_with_index do |fresh_ingredient_range, fresh_ingredient_range_idx|
    next if deduped_ranges.any? { |deduped_range| deduped_range.cover?(fresh_ingredient_range) }

    accumulated_range = fresh_ingredient_range
    other_ranges = fresh_ingredient_ranges[(fresh_ingredient_range_idx + 1)..-1]

    # Accumulate until accumulated_range doesn't change
    accumulated_range_changed = true
    until accumulated_range_changed == false
      accumulated_range_changed = false

      other_ranges.each do |other_range|
        if other_range.overlap?(accumulated_range)
          new_range = combine_ranges(accumulated_range, other_range)

          if accumulated_range != new_range
            accumulated_range = combine_ranges(accumulated_range, other_range)
            accumulated_range_changed = true
          end
        end
      end
    end

    overlapping_deduped_range_idx = deduped_ranges.find_index do |deduped_range|
      deduped_range.overlap?(accumulated_range)
    end

    if overlapping_deduped_range_idx.nil?
      deduped_ranges << accumulated_range
    else
      deduped_ranges[overlapping_deduped_range_idx] = accumulated_range
    end
  end

  deduped_ranges.reduce(0) do |acc, range|
    acc + (range.last - range.first + 1)
  end
end

puts "=== Part 1 ==="
puts "Example solution: #{count_fresh_ingredients('./example_input.txt')}"
puts "Solution: #{count_fresh_ingredients('./input.txt')}"


puts "=== Part 2 ==="
puts "Example solution: #{count_unique_fresh_ingredients('./example_input.txt')}"
puts "Solution: #{count_unique_fresh_ingredients('./input.txt')}"