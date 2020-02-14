module Enumerable
  def my_each
    iarr = self
    size = iarr.length
    x = 0
    until x == size
      yield(iarr[x])
      x += 1
    end
  end

  def my_each_with_index
    iarr = self
    size = iarr.length
    x = 0
    until x == size
      yield(iarr[x], x)
      x += 1
    end
  end

  def my_select
    varr = []
    iarr = self
    iarr.my_each { |num| varr << num if yield(num) == true }
    varr
  end

  def my_all?
    iarr = self
    iarr.my_each { |num| return false unless yield(num) }
    true
  end

  def my_any?
    iarr = self
    iarr.my_each { |num| return true unless yield(num) }
    false
  end

  def my_none?
    iarr = self
    iarr.my_each { |num| return false if yield(num) }
    true
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

  def my_map(val = nil)
    varr = []
    my_each { |num| varr.push(val.call(num)) } if val
    my_each { |num| varr.push(yield(num)) } if val.nil?
    varr
  end

  def my_map2(val)
    varr = []
    my_each { |num| varr.push(val.call(num)) }
    varr
  end

  def my_map3(*val)
    varr = []
    iarr = self
    iarr.my_each do |num|
      varr.push(val[0].call(num)) unless val.empty?
      varr.push(yield(num)) if val.empty?
    end
    varr
  end

  def my_inject
    var = self
    res = self[0]
    var.my_each_with_index { |num, ind| res = yield(res, num) if ind.positive? }
    res
  end
end

def multiply_els(arr2)
  arr2.my_inject { |resultado, num| resultado * num }
end

arr = [8, 3, 5, 5, 6, 6]
arr2 = [2, 4, 5]
x2 = proc { |x| x * 2 }

puts '-----my each-----'
arr.my_each { |num1| puts num1 }
puts '-----my each with index-----'
arr.my_each_with_index { |num1, num2| p num1.to_s + ':' + num2.to_s }
puts '-----my select?-----'
p(arr.my_select { |num| num > 4 })
puts '-----my all?--------'
res = arr.all? { |num| num > 2 }
puts res
res = arr.all? { |num| num > 6 }
puts res
puts '-----my any--------'
res = arr.any? { |num| num > 5 }
puts res
res = arr.any? { |num| num > 9 }
puts res
puts '-----my none?--------'
res = arr.none? { |num| num > 5 }
puts res
res = arr.none? { |num| num > 9 }
puts res
puts '-----my count?--------'
res = arr.my_count
puts res
res = arr.my_count(6)
puts res
puts(arr.my_count { |num| num > 4 })
puts '-----my map?--------'
puts(arr.my_map { 'map' })
puts(arr.my_map { |num| num * num })
puts '-----my inject--------'
puts(arr.my_inject { |resultado, num| resultado + num })
puts '-----my inject with multiply_els--------'
puts multiply_els(arr2)
puts '-----map with procs--------'
puts arr2.my_map2(x2)
puts '-----map with procs & cblovk--------'
puts arr2.my_map3(x2)
puts(arr2.my_map3 { |num| num * num })
puts(arr2.my_map3(x2) { |num| num * num })
