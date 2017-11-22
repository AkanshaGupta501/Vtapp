require 'data_magic'
module CustomData
  def generate_account_number
    rand(1e9...1e16).to_i
  end

  def generate_bank_code
    Time.now.to_i
  end

  def generate_random_name
    Time.now.to_i.to_s + "testing"
  end
end

DataMagic.add_translator CustomData