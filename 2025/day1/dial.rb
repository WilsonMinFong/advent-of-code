class Dial
  MIN_POSITION = 0
  MAX_POSITION = 100

  attr_reader :position, :num_encounters_with_zero

  def initialize(position = 50)
    @position = position
    @num_encounters_with_zero = 0
  end

  def move(amount)
    # TODO: Refactor this to use modulo and calculate encounters with zero externally
    # @position = (@position + amount) % MAX_POSITION

    if amount.positive?
      amount.times do
        @position += 1
        @position = MIN_POSITION if @position == MAX_POSITION

        @num_encounters_with_zero += 1 if @position == MIN_POSITION
      end
    elsif amount.negative?
      amount.abs.times do
        @position -= 1
        @position = MAX_POSITION - 1 if @position < MIN_POSITION

        @num_encounters_with_zero += 1 if @position == MIN_POSITION
      end
    end
  end
end