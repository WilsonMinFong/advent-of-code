# Brute force solution: Loop through each permutation of two numbers with ordered digits
# Better: Find greatest 10s place joltage, then iterate through remaining joltages to find greatest 1s

def largest_joltage(str)
  tens_joltage_battery = 0
  ones_joltage_battery = 0

  joltages = str.chomp.chars.map(&:to_i)

  joltages[0...(joltages.length - 1)].each_with_index do |n, idx|
    if n > tens_joltage_battery
      tens_joltage_battery = n
      ones_joltage_battery = 0
    end

    if n == tens_joltage_battery
      joltages[(idx + 1)..joltages.length].each do |m|
        ones_joltage_battery = m if m > ones_joltage_battery
      end
    end
  end

  tens_joltage_battery * 10 + ones_joltage_battery
end

example_joltage = 0

File.readlines('./example_input.txt').each do |line|
  example_joltage += largest_joltage(line)
end

puts "Example total output joltage: #{example_joltage}"

problem_joltage = 0

File.readlines('./input.txt').each do |line|
  problem_joltage += largest_joltage(line)
end

puts "Problem total output joltage: #{problem_joltage}"