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
    varr = Array.new
    iarr = self
    iarr.my_each do |num|
      varr << num if yield(num) == true
    end
    varr
  end

  def my_all?
    iarr = self
    iarr.my_each do |num|
      return false unless yield(num)
    end
    true
  end

  def my_any?
    iarr = self
    iarr.my_each do |num|
      return true unless yield(num)
    end
    false
  end
end

arr = [8, 3, 5, 6]
puts 'my each'
arr.my_each { |num1| puts num1 }
puts 'my each with index'
arr.my_each_with_index { |num1, num2| p num1.to_s + ':' + num2.to_s }
puts 'my select--------------?'
p(arr.my_select { |num| num > 4 })
puts 'my all--------------?'
res = arr.all? { |num| num > 2 }
puts res
res = arr.all? { |num| num > 6 }
puts res
puts 'my any--------------?'
res = arr.any? { |num| num > 5 }
puts res
res = arr.any? { |num| num > 9 }
puts res
