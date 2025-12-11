def parse_input(filename)
  nodes = {}

  File.readlines(filename).each do |line|
    (key, *neighboring_nodes) = line.chomp.split
    nodes[key.delete(':')] = neighboring_nodes
  end

  nodes
end

def find_output_paths(nodes)
  num_output_paths = 0
  queue = nodes['you']

  until queue.empty?
    next_node = queue.shift
    neighboring_nodes = nodes[next_node]

    if neighboring_nodes[0] == 'out'
      num_output_paths += 1
    else
      queue.concat(neighboring_nodes)
    end
  end

  num_output_paths
end

def part1(filename)
  find_output_paths(parse_input(filename))
end

puts "=== Part 1 ==="
puts "Example solution: #{part1('./example_input.txt')}"
puts "Solution: #{part1('./input.txt')}"