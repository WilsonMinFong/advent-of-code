require 'set'

class JunctionBox
  attr_reader :x, :y, :z

  def initialize(x, y, z)
    @x = x
    @y = y
    @z = z
  end

  def self.distance_between(junction_box_1, junction_box_2)
    (junction_box_1.x - junction_box_2.x) ** 2 +
      (junction_box_1.y - junction_box_2.y) ** 2 +
      (junction_box_1.z - junction_box_2.z) ** 2 
  end
end

class Circuit
  attr_reader :junction_boxes

  def initialize(junction_boxes)
    @junction_boxes = Set.new(junction_boxes)
  end

  def merge(other_circuit)
    self.class.new(junction_boxes + other_circuit.junction_boxes)
  end

  def include?(junction_box)
    @junction_boxes.include?(junction_box)
  end

  def length
    @junction_boxes.length
  end
end

class CircuitManager
  attr_reader :circuits, :junction_boxes

  def self.from_file(filename)
    circuit_manager = new

    File.readlines(filename).each do |line|
      x, y, z = line.split(',').map(&:to_i)
      circuit_manager.manage_junction_box(JunctionBox.new(x, y, z))  
    end

    circuit_manager
  end

  def initialize
    @junction_boxes = []
    @circuits = []
  end
  
  def manage_junction_box(junction_box)
    @junction_boxes << junction_box
    @circuits << Circuit.new([junction_box])
  end

  def find_circuit(junction_box)
    @circuits.find { |circuit| circuit.include?(junction_box) }
  end

  def union_circuit(junction_box_a, junction_box_b)
    circuit_a = find_circuit(junction_box_a)
    circuit_b = find_circuit(junction_box_b)

    return if circuit_a == circuit_b

    new_circuit = circuit_a.merge(circuit_b)
    @circuits.delete(circuit_a)
    @circuits.delete(circuit_b)
    @circuits << new_circuit
  end

  def join_shortest_connections(n)
    junction_box_distances.keys.first(n).each do |(junction_box_1, junction_box_2)|
      union_circuit(junction_box_1, junction_box_2)
    end
  end

  def join_until_one_circuit
    junction_box_distances.keys.each do |(junction_box_1, junction_box_2)|
      union_circuit(junction_box_1, junction_box_2)

      return [junction_box_1, junction_box_2] if circuits.length == 1
    end
  end

  def product_of_three_largest_circuits
    circuits
      .map(&:length)
      .sort { |a, b| b <=> a }
      .take(3)
      .reduce(:*)
  end

  private

  def junction_box_distances
    @junction_box_distances ||= @junction_boxes.combination(2).reduce({}) do |map, (junction_box_1, junction_box_2)|
      map[[junction_box_1, junction_box_2]] = JunctionBox.distance_between(junction_box_1, junction_box_2)
      map
    end.sort_by { |_, distance| distance }.to_h
  end
end

def part1(filename, num_connections)
  circuit_manager = CircuitManager.from_file(filename)
  circuit_manager.join_shortest_connections(num_connections)
  circuit_manager.product_of_three_largest_circuits
end

def part2(filename)
  circuit_manager = CircuitManager.from_file(filename)
  (junction_box_1, junction_box_2) = circuit_manager.join_until_one_circuit
  junction_box_1.x * junction_box_2.x
end

puts "=== Part 1 ==="
puts "Example solution: #{part1('./example_input.txt', 10)}"
puts "Solution: #{part1('./input.txt', 1000)}"

puts "=== Part 2 ==="
puts "Example solution: #{part2('./example_input.txt')}"
puts "Solution: #{part2('./input.txt')}"