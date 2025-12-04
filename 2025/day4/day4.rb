DIRECTIONS = [
  [0, 1], # up
  [1, 1], # up-right
  [1, 0], # right
  [1, -1], # down-right
  [0, -1], # down
  [-1, -1], # down-left
  [-1, 0], # left
  [-1, 1], # up-left
]

MAX_ADJACENT_ROLLS_OF_PAPER = 4
PAPER_CHARACTER = '@'

def accessible_roll_of_paper?(grid, x, y)
  return false if grid[y][x] != PAPER_CHARACTER

  num_adjacent_rolls_of_paper = 0
  length_x = grid[0].length
  length_y = grid.length

  DIRECTIONS.each do |(dx, dy)|
    adjacent_x = x + dx
    adjacent_y = y + dy
  
    # check boundaries
    if adjacent_x < 0 || adjacent_y < 0 || adjacent_x >= length_x || adjacent_y >= length_y
      next
    end

    num_adjacent_rolls_of_paper += 1 if grid[adjacent_y][adjacent_x] == PAPER_CHARACTER
  end

  num_adjacent_rolls_of_paper < MAX_ADJACENT_ROLLS_OF_PAPER
end

def num_accessible_rolls_of_paper(grid)
  length_x = grid[0].length
  length_y = grid.length
  total = 0

  length_x.times do |x|
    length_y.times do |y|
      if accessible_roll_of_paper?(grid, x, y)
        total += 1
      end
    end
  end

  total
end

def parse_grid(filename)
  File.readlines(filename).map { |line| line.chomp.split('') }
end

example_grid = parse_grid('./example_input.txt')
grid = parse_grid('./input.txt')


puts '=== Part 1 ==='
puts "Example input result: #{num_accessible_rolls_of_paper(example_grid)}"
puts "Input result: #{num_accessible_rolls_of_paper(grid)}"