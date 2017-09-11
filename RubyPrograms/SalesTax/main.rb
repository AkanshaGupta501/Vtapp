require_relative 'product'
require_relative 'invoice'

product_array = Array.new

begin
  print 'Name of the product : '
  product_name = gets.chomp

  print 'Is Product Imported? (yes/no): '
  imported = gets.chomp

  print 'Exempted from tax? (yes/no): '
  exempted_sales_tax = gets.chomp

  print 'Price of Product: '
  price = gets.to_f

  product_array.push(Product.new(product_name, price, imported, exempted_sales_tax))
  print 'Do you want to add more products ? (yes/no):'
  choice = gets.chomp
end while(/^(y|yes)$/i === choice)

invoice = Invoice.new(product_array)
puts invoice.display
