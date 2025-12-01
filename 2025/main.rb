require './dial'

dial = Dial.new
num_zero = 0

def parse_instruction(str)
  direction = str[0]
  value = str[1..].to_i
  direction == 'R' ? value : -value
end

File.foreach('input.txt') do |line|
  dial.move(parse_instruction(line))

  num_zero += 1 if dial.position.zero?
end

puts num_zero