# rubocop:disable Metrics/ModuleLength,
# rubocop:disable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
# rubocop:disable Metrics/MethodLength:

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

    iarr = to_a
    size = iarr.length
    x = 0
    until x == size
      yield(iarr[x], x)
      x += 1
    end
    self
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
    elsif val.is_a? Regexp
      iarr.my_each { |num| status = false unless num =~ val }
    elsif val.is_a? Class
      iarr.my_each { |num| status = false unless num.is_a? val }
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
    elsif val.is_a? Regexp
      iarr.my_each { |num| status = true if num =~ val }
    elsif val.is_a? Class
      iarr.my_each do |num|
        status = true if num.is_a? val
      end
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
    elsif val.is_a? Regexp
      iarr.my_each { |num| status = false if num =~ val }
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
    iarr = to_a
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

# rubocop:enable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
# rubocop:enable Metrics/ModuleLength
# rubocop:enable Metrics/MethodLength:

def multiply_els(arr2)
  arr2.my_inject { |resultado, num| resultado * num }
end
