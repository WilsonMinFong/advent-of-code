require './decoder'

decoder = Decoder.new

print "Enter filename (default: input.txt): "
filename = gets.chomp
filename = 'input.txt' if filename.empty?

print "Enter method (simple/complex): "
method = gets.chomp.downcase

num_zero = if method == 'simple'
             decoder.simple_decode(filename)
           else
             decoder.complex_decode(filename)
           end

puts "Result: #{num_zero}"