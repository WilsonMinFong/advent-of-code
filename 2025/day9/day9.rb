def calculate_area(corner_1, corner_2)
  ((corner_1[0] - corner_2[0] + 1) * (corner_1[1] - corner_2[1] + 1)).abs
end

def find_max_area(filename)
  corners = File.readlines(filename).map do |line|
    line.chomp.split(',').map(&:to_i)
  end

  corners.combination(2).map do |(corner_1, corner_2)|
    calculate_area(corner_1, corner_2)
  end.max
end

puts "=== Part 1 ==="
puts "Example solution: #{find_max_area('./example_input.txt')}"
puts "Solution: #{find_max_area('./input.txt')}"