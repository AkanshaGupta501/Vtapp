require_relative 'product'

class Invoice
  attr_accessor :products

  def initialize(products_array)
    @products = products_array
	@invoice_header = ["Name","Price","Tax","MRP"]
  end

  def total_price
    calculate_total_price.round(2)
  end

  def calculate_total_price
    products.inject(0) { |sum, product| sum += product.net_price }
  end

  def generate
    @invoice_header.each{|header| print "#{header.ljust(12)}"}
    puts products
   "\nGrand Total : Rs#{ total_price }/-"
  end
end
 