class Product
  REGEX_FOR_NO = /^(n|no)$/i
  REGEX_FOR_YES = /^(y|yes)$/i
  REGEX_FOR_EXEMPTED_TAX = /book|food|medicine(s?)/i
  SALES_TAX = 0.1
  IMPORT_DUTY = 0.05
  attr_reader :price, :net_price, :name, :total_tax, :exempted_from_sales_tax, :imported

  def initialize(name, price, imported, exempted_sales_tax)
    @name = name
    @exempted_from_sales_tax = exempted_sales_tax
    @imported = imported
    @price = price
    @total_tax = calculate_total_tax
    @net_price = price_including_tax
  end

  def price_including_tax
    price + total_tax
  end

  def exempted_from_sales_tax?
    !(exempted_from_sales_tax =~ REGEX_FOR_NO)
  end

  def calculate_sales_tax
    @exempted_from_sales_tax = 'y' if name =~ REGEX_FOR_EXEMPTED_TAX
    (exempted_from_sales_tax? ? 0 : (price * SALES_TAX)).round(2)
  end

  def import_duty?
    imported =~ REGEX_FOR_YES
  end

  def calculate_import_duty
    (import_duty? ? (price * IMPORT_DUTY) : 0).round(2)
  end

  def calculate_total_tax
    (calculate_sales_tax + calculate_import_duty).round(2)
  end

  def to_s
    "\n#{ name.ljust(12) }Rs#{ price }\tRs#{ total_tax }\t Rs#{ net_price }"
  end
end