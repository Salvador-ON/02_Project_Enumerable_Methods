arr = [8, 3, 5, 5, 6, 6]
arr2 = [2, 4, 5]
arr3 = [3, 3, 4, 3]
arr4 = [3, 3, 3, 3]
arr5 = [3, 3, nil, 3]
arr6 = [3, 3, 3]
arr7 = []
x2 = proc { |num| num * 2 }

puts '-----my each-----'
p(arr.my_each { |num1| num1 })
puts '-----my each with index-----'
hash = {}
%w[cat dog wombat].my_each_with_index { |item, index| hash[item] = index }
p hash
puts '-----my select?-----'
p(arr.my_select { |num| num > 4 })
puts '-----my all? true and false--------'
p(arr.my_all? { |num| num > 2 })
p(arr.my_all? { |num| num > 6 })
puts '-----my all? no block and with argument false and true--------'
p(arr3.my_all?(3))
p(arr4.my_all?(3))
puts '-----my all? no block and no argument false and true--------'
p(arr5.my_all?)
p(arr4.my_all?)
puts '-----my any? true and false--------'
p(arr.my_any? { |num| num > 2 })
p(arr.my_any? { |num| num > 9 })
puts '-----my any? no block and with argument true and false--------'
p(arr3.my_any?(3))
p(arr4.my_any?(4))
puts '-----my any? no block and no argument true and true--------'
p(arr5.my_any?)
p(arr4.my_any?)
puts '-----my none?--------'
p(arr.my_none? { |num| num > 5 })
p(arr.my_none? { |num| num > 9 })
puts '-----my none? argument--------'
p(arr6.my_none?(Float))
puts '-----my none? no block--------'
p(arr7.my_none?)
puts '-----my count?--------'
p(arr.my_count)
p(arr.my_count(6))
p(arr.my_count { |num| num > 4 })
puts '-----my inject--------'
p(arr.my_inject { |resultado, num| resultado + num })
puts '-----my inject with multiply_els--------'
p multiply_els(arr2)
puts '-----map with procs --------'
p arr2.my_map(x2)
puts '-----map with block--------'
p(arr2.my_map { |num| num * num })
puts '-----map with procs & block--------'
p(arr2.my_map(x2) { |num| num * num })
puts '-----map with anything-------'
p(arr2.my_map)
puts '-----my inject using block and inject  151200 --------------'
p((5..10).inject(1) { |product, n| product * n }) #=> 151200
puts '-----my inject using words--------------'
p(%w[cat sheep bear].inject do |memo, word|
  memo.length > word.length ? memo : word
end)
