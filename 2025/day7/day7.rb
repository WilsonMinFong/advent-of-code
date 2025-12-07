def get_num_beam_splits(filename)
  current_beam_positions = []
  num_beam_splits = 0

  File.readlines(filename, chomp: true).each_with_index do |line, line_num|
    if line_num == 0
      current_beam_positions = [line.chars.find_index('S')]
    else
      new_beam_positions = []

      current_beam_positions.each do |current_beam_position|
        if line[current_beam_position] == '^'
          num_beam_splits += 1

          new_beam_positions << current_beam_position - 1 unless current_beam_position == 0
          new_beam_positions << current_beam_position + 1 unless current_beam_position == line.length - 1
        else
          new_beam_positions << current_beam_position
        end
      end

      current_beam_positions = new_beam_positions.uniq
    end
  end

  num_beam_splits
end

def get_num_timelines(filename)
  current_beam_positions = {}
  new_beam_positions = Hash.new(0)

  File.readlines(filename, chomp: true).each_with_index do |line, line_num|
    if line_num == 0
      current_beam_positions = { line.chars.find_index('S') => 1}
    else
      new_beam_positions = Hash.new(0)

      current_beam_positions.each do |current_beam_position, n_timelines_to_current_beam_position|
        if line[current_beam_position] == '^'
          new_beam_positions[current_beam_position - 1] += n_timelines_to_current_beam_position unless current_beam_position == 0
          new_beam_positions[current_beam_position + 1] += n_timelines_to_current_beam_position unless current_beam_position == line.length - 1
        else
          new_beam_positions[current_beam_position] += n_timelines_to_current_beam_position
        end
      end

      current_beam_positions = new_beam_positions
    end
  end

  new_beam_positions.values.reduce(&:+)
end

puts "=== Part 1 ==="
puts "Example solution: #{ get_num_beam_splits('./example_input.txt')}"
puts "Solution: #{get_num_beam_splits('./input.txt')}"

puts "=== Part 2 ==="
puts "Example solution: #{ get_num_timelines('./example_input.txt')}"
puts "Solution: #{get_num_timelines('./input.txt')}"