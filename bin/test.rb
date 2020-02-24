require_relative '../lib/enumerables.rb/'

array = [1,2,3,4,5,6,7]

puts array.my_any?(Numeric)
puts array.any?(Numeric)

puts array.any?(Numeric) == array.my_any?(Numeric)
