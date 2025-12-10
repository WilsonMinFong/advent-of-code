def parse_input(filename)
  File.readlines(filename).map do |line|
    line_elements = line.chomp.split(' ')
    raw_indicator_lights, *raw_buttons, _raw_joltages = line_elements

    indicator_lights = raw_indicator_lights.delete("[]").split('').map { |el| el == '#' }
    buttons = raw_buttons.map { |raw_button| raw_button.delete("()").split(',').map(&:to_i) }

    [indicator_lights, buttons, _raw_joltages]
  end
end

def fewest_button_presses(goal_indicator_lights, buttons)
  default_lights = Array.new(goal_indicator_lights.length) { false }

  # [current_indicator_lights, next_button_press, depth]
  queue = buttons.map { |button| [default_lights.dup, button, 1] }

  while queue.length > 0
    (current_indicator_lights, button, depth) = queue.shift

    button.each do |light_idx|
      current_indicator_lights[light_idx] = !current_indicator_lights[light_idx]
    end

    return depth if current_indicator_lights == goal_indicator_lights

    buttons.reject { |next_button| next_button == button }.each do |next_button|
      queue << [current_indicator_lights.dup, next_button, depth + 1]
    end
  end
end

def sum_fewest_button_presses(filename)
  parsed_input = parse_input(filename)
  fewest_button_presses = parsed_input.map do |(goal_indicator_lights, buttons, _)|
    fewest_button_presses(goal_indicator_lights, buttons)
  end

  fewest_button_presses.to_a.reduce(&:+)
end

puts "--- Part 1 ---"
puts "Example solution: #{sum_fewest_button_presses('./example_input.txt')}"
puts "Solution: #{sum_fewest_button_presses('./input.txt')}"