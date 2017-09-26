require 'data_magic'
module CustomData
  def generate_account_number
    rand(1e9...1e16).to_i
  end

  def generate_bank_code
    Time.now.to_i
  end
end

DataMagic.add_translator CustomData