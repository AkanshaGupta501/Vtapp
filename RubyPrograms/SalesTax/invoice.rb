require_relative 'product'

class Invoice
  attr_accessor :products
  INVOICE_HEADER = ["Name", "Price", "Tax", "MRP"]

  def initialize(products_array)
    @products = products_array
  end

  def total_price
    calculate_total_price.round(2).to_i
  end

  def calculate_total_price
    products.inject(0) { |sum, product| sum += product.net_price }
  end
  
  def display
    INVOICE_HEADER.each{|header| print "#{header.ljust(12)}"}
    puts products
    puts "\nGrand Total : Rs#{ total_price }/-"
  end
end
 