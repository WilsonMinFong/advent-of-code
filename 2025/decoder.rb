require './dial'

class Decoder
  def initialize
    @dial = Dial.new
  end

  def simple_decode(filename = 'input.txt')
    num_zero = 0

    File.foreach(filename) do |line|
      @dial.move(parse_instruction(line))

      num_zero += 1 if @dial.position.zero?
    end

    num_zero
  end

  def complex_decode(filename = 'input.txt')
    File.foreach(filename) do |line|
      @dial.move(parse_instruction(line))
    end

    @dial.num_encounters_with_zero
  end

  private

  def parse_instruction(str)
    direction = str[0]
    value = str[1..].to_i
    direction == 'R' ? value : -value
  end
end