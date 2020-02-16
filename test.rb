def my_inject(*val)
  res = nil
  param = nil
  val.my_each do |num|
    res = num if num.is_a? Numeric
    param = num unless num.is_a? Numeric
  end
  iarr = res ? to_a : to_a[1..-1]
  res ||= to_a[0]

  iarr.to_a.my_each { |num| res = yield(res, num) } if block_given?
    
iarr.to_a.my_each { |num| res = res.public_send(param, num) } if param
  res
end