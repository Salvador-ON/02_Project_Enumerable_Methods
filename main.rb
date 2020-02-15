module Enumerable
  def my_each
    return to_enum :my_each unless block_given?

    iarr = self
    size = iarr.length
    x = 0
    until x == size
      yield(iarr[x])
      x += 1
    end
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
arr3 = [3, 3, 4, 3]
arr4 = [3, 3, 3, 3]
arr5 = [3, 3, nil, 3]
x2 = proc { |x| x * 2 }

puts '-----my each-----'
arr.my_each { |num1| puts num1 }
puts '-----my each with index-----'
arr.my_each_with_index { |num1, num2| p num1.to_s + ':' + num2.to_s }
puts '-----my select?-----'
p(arr.my_select { |num| num > 4 })
puts '-----my all? true and false--------'
puts(arr.my_all? { |num| num > 2 })
puts(arr.my_all? { |num| num > 6 })
puts '-----my all? no block and with argument false and true--------'
puts(arr3.my_all?(3))
puts(arr4.my_all?(3))
puts '-----my all? no block and no argument false and true--------'
puts(arr5.my_all?)
puts(arr4.my_all?)
puts '-----my any? true and false--------'
puts(arr.my_any? { |num| num > 2 })
puts(arr.my_any? { |num| num > 9 })
puts '-----my any? no block and with argument true and false--------'
puts(arr3.my_any?(3))
puts(arr4.my_any?(4))
puts '-----my any? no block and no argument true and true--------'
puts(arr5.my_any?)
puts(arr4.my_any?)
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
puts '-----map with procs --------'
puts arr2.my_map3(x2)
puts '-----map with block--------'
puts(arr2.my_map3 { |num| num * num })
puts '-----map with procs & block--------'
puts(arr2.my_map3(x2) { |num| num * num })
