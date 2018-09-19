class Converter
  def less_than(min, cutoff, req_per)
  req_per = 100.0 - req_per
  biased_range = cutoff - min
  ((biased_range / 90.0) * req_per) + min
  end

  def more_than_counter(max, cutoff, req_per)
    req_per = req_per - 10
    biased_range = max - cutoff
    ((biased_range / 90)  * req_per) + cutoff
  end
end

obj = Converter.new
input = ARGV[0]
if(input == 'less')
  obj.less_than(ARGV[1], ARGV[2], ARGV[3])
else
  obj.more_than_counter(ARGV[1], ARGV[2], ARGV[3])
end



