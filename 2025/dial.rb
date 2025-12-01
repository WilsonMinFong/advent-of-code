class Dial
  MIN_POSITION = 0
  MAX_POSITION = 100

  attr_reader :position

  def initialize(position = 50)
    @position = position
  end

  def move(amount)
    @position = (@position + amount) % MAX_POSITION
  end
end