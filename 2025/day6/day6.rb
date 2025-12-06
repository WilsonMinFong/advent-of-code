def parse_input_part1(filename)
  expressions = []

  File.readlines(filename).each do |line|
    line.split.map(&:strip).each_with_index do |el, col_idx|
      if expressions.length == col_idx
        expressions << [el]
      else
        expressions[col_idx] << el
      end
    end
  end

  expressions
end

def parse_input_part2(filename)
  expressions = []
  lines = File.readlines(filename)
  operands_line = lines.pop

  operands_line.chars.each_with_index do |char, char_idx|
    expressions << [char] if char == "+" || char == "*"

    col_chars = lines.map { |line| line[char_idx] }
    col_chars.reject! { |char| char == " " }

    # Reject empty col
    next if col_chars.empty?

    expressions.last.unshift(col_chars.join)
  end

  expressions
end

def calculate_grand_total(expressions)
  expressions.reduce(0) do |sum, expression|
    operand = expression.pop.to_sym
    sum + expression.map(&:to_i).reduce(&operand)
  end
end

puts "=== Part 1 ==="
puts "Example solution: #{calculate_grand_total(parse_input_part1('./example_input.txt'))}"
puts "Solution: #{calculate_grand_total(parse_input_part1('./input.txt'))}"

puts "=== Part 2 ==="
puts "Example solution: #{calculate_grand_total(parse_input_part2('./example_input.txt'))}"
puts "Solution: #{calculate_grand_total(parse_input_part2('./input.txt'))}"