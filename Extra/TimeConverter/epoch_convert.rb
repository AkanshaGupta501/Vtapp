require 'time'
class String
  def epoch_to_time
    Time.at(self.to_i)
  end
end

puts ARGV[0].epoch_to_time