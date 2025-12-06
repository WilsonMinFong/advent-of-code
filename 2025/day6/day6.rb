def parse_input(filename)
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

def calculate_grand_total(expressions)
  expressions.reduce(0) do |sum, expression|
    operand = expression.pop.to_sym
    sum + expression.map(&:to_i).reduce(&operand)
  end
end

puts "=== Part 1 ==="
puts "Example solution: #{calculate_grand_total(parse_input('./example_input.txt'))}"
puts "Solution: #{calculate_grand_total(parse_input('./input.txt'))}"