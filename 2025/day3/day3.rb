def largest_joltage_n(str, n)
  joltages = str.chomp.chars.map(&:to_i)
  return 0 if joltages.length < n
  current_index = 0
  result = 0

  n.times do |i|
    limit_index = joltages.length - (n - i)
    
    window = joltages[current_index..limit_index]
    max_val = window.max
    
    found_index = current_index + window.index(max_val)
    
    result = result * 10 + max_val
    current_index = found_index + 1
  end

  result
end

example_joltage_2 = 0
example_joltage_12 = 0

File.readlines('./example_input.txt').each do |line|
  example_joltage_2 += largest_joltage_n(line, 2)
  example_joltage_12 += largest_joltage_n(line, 12)
end

problem_joltage_2 = 0
problem_joltage_12 = 0

File.readlines('./input.txt').each do |line|
  problem_joltage_2 += largest_joltage_n(line, 2)
  problem_joltage_12 += largest_joltage_n(line, 12)
end

puts "=== Part 1 ==="
puts "Example total output joltage: #{example_joltage_2}"
puts "Problem total output joltage: #{problem_joltage_2}"

puts "=== Part 2 ==="
puts "Example total output joltage: #{example_joltage_12}"
puts "Problem total output joltage: #{problem_joltage_12}"