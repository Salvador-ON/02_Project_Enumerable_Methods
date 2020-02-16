module Enumerable
  def my_each
    return to_enum :my_each unless block_given?

    iarr = to_a
    size = iarr.length
    x = 0
    until x == size
      yield(iarr[x])
      x += 1
    end
    self
  end

  def my_each_with_index
    return to_enum :my_each_with_index unless block_given?

    iarr = self
    size = iarr.length
    x = 0
    until x == size
      yield(iarr[x], x)
      x += 1
    end
  end

  def my_select
    return to_enum :my_select unless block_given?

    varr = []
    iarr = self
    iarr.my_each { |num| varr << num if yield(num) == true }
    varr
  end

  def my_all?(val = nil)
    iarr = self
    status = true
    if block_given? && val.nil?
      iarr.my_each { |num| status = false unless yield(num) }
    elsif val
      status = true
      iarr.my_each do |num|
        status = true if num == val && status == true
        status = false if num != val && status == true
      end
    else
      status = true
      iarr.my_each do |num|
        status = true if num && num != false && status == true
        status = false if (num.nil? || num == false) && status == true
      end
    end
    status
  end

  def my_any?(val = nil)
    iarr = self
    status = false
    if block_given? && val.nil?
      iarr.my_each { |num| status = true if yield(num) }
    elsif val
      status = false
      iarr.my_each do |num|
        status = true if num == val && status == false
      end
    else
      status = false
      iarr.my_each do |num|
        status = true if num && status == false
      end
    end
    status
  end

  def my_none?(val = nil)
    status = true
    iarr = self
    if block_given?
      iarr.my_each do |num|
        status = false if yield(num)
      end
    elsif val.is_a? Class
      iarr.my_each do |num|
        status = false if num.is_a? val
      end
    elsif val
      iarr.my_each do |num|
        status = false if val == num
      end
    elsif val.nil? && !block_given?
      iarr.my_each do |num|
        status = false if num
      end
    end
    status
  end

  def my_count(val = nil)
    iarr = self
    size = iarr.length
    x = 0
    if !block_given? && val.nil?
      x = size
    elsif val
      iarr.my_each { |num| x += 1 if num == val }
    else
      iarr.my_each { |num| x += 1 if yield(num) }
    end
    x
  end

  def my_map(*val)
    return to_enum :my_map unless block_given?

    varr = []
    iarr = self
    iarr.my_each do |num|
      varr.push(val[0].call(num)) unless val.empty?
      varr.push(yield(num)) if val.empty?
    end
    varr
  end

  def my_inject(*val)
    res = nil
    param = nil
    val.my_each { |num| res = num if num.is_a? Numeric }
    val.my_each { |num| param = num unless num.is_a? Numeric }
    iarr = res ? to_a : to_a[1..-1]
    res ||= to_a[0]
    iarr.to_a.my_each { |num| res = yield(res, num) } if block_given?
    iarr.to_a.my_each { |num| res = res.public_send(param, num) } if param
    res
  end
end

def multiply_els(arr2)
  arr2.my_inject { |resultado, num| resultado * num }
end

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
