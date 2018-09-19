require 'time'
class String
  def time_to_epoch
    DateTime.parse(self).to_time.to_i
  end
end

puts ARGV[0].time_to_epoch
