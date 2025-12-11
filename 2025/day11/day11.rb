def parse_input(filename)
  nodes = {}

  File.readlines(filename).each do |line|
    (key, *neighboring_nodes) = line.chomp.split
    nodes[key.delete(':')] = neighboring_nodes
  end

  nodes
end

def find_you_output_paths(nodes)
  num_output_paths = 0
  queue = nodes['you']

  until queue.empty?
    current_node = queue.shift
    neighboring_nodes = nodes[current_node]

    if neighboring_nodes[0] == 'out'
      num_output_paths += 1
    else
      queue.concat(neighboring_nodes)
    end
  end

  num_output_paths
end

def find_server_output_paths(nodes)
  # memo[(node, visited_dac, visited_fft)] = count of valid paths to 'out'
  memo = {}

  count_paths = ->(node, visited_dac, visited_fft) {
    # Update visited flags based on current node
    visited_dac = true if node == 'dac'
    visited_fft = true if node == 'fft'
    
    state_key = [node, visited_dac, visited_fft]
    return memo[state_key] if memo.key?(state_key)

    neighboring_nodes = nodes[node]

    count = if neighboring_nodes[0] == 'out'
      (visited_dac && visited_fft) ? 1 : 0
    else
      neighboring_nodes.sum { |neighbor| count_paths.call(neighbor, visited_dac, visited_fft) }
    end

    memo[state_key] = count
  }

  nodes['svr'].sum { |start_node| count_paths.call(start_node, false, false) }
end

def part1(filename)
  find_you_output_paths(parse_input(filename))
end

def part2(filename)
  find_server_output_paths(parse_input(filename))
end

puts "=== Part 1 ==="
puts "Example solution: #{part1('./example_input_1.txt')}"
puts "Solution: #{part1('./input.txt')}"

puts "=== Part 2 ==="
puts "Example solution: #{part2('./example_input_2.txt')}"
puts "Solution: #{part2('./input.txt')}"