def parse_input(filename)
  blocks = []
  block = []

  File.readlines(filename).each do |line|
    if line.chomp.empty?
      blocks << block
      block = []
    else
      block << line.chomp
    end
  end

  blocks << block

  (*presents, spaces) = blocks

  presents_hash = {}
  presents.each do |present|
    presents_hash[present[0].delete(':').to_i] = present[1..-1].map { |row| row.split('') }
  end

  spaces = spaces.map do |space|
    space.split(' ').each_with_index.map do |token, idx|
      if idx == 0
        token.delete(':').split('x').map(&:to_i)
      else
        token.to_i
      end
    end
  end

  [presents_hash, spaces]
end

def does_region_fit(region, presents)
  (dimensions, *present_counts) = region

  max_size = dimensions.reduce(&:*)
  presents_max_area = 0

  present_counts.each_with_index do |present_count, idx|
    presents_max_area += (present_count * presents[idx][0].length * presents[idx].length)
  end

  presents_max_area <= max_size
end

def part1(filename)
  (presents, regions) = parse_input(filename)

  regions.reduce(0) { |sum, region| does_region_fit(region, presents) ? sum + 1 : sum }
end

puts '=== Part 1 ==='
puts "Example solution: #{part1('./input.txt')}" # WRONG!
puts "Solution: #{part1('./input.txt')}"