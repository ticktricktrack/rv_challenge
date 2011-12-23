# This is basically an eval solution, eval is never too pretty, but always flexible.
# And flexible was a key spec! 

# if needed, a formula can be stored with each product
# when the basket items are cycled through, the formula will be fed with quantity and the original price

# Since your Challenge was a perfect candidate for Cucumber Tables, I skipped any RSpec.
# RSpec would have only brought overtesting

class Product
  attr_accessor :product_code, :name, :price, :discount_formula
  
  # since there is no database, I just went for a class variable
  # this stores the basic data for each product, not the basket
  # the basket is a volatile object
  @@list = []
  
  def self.list
    @@list
  end
  
  def self.cleanup
    @@list = []
  end
  
  def self.total_price(basket)
    sum = 0
    @@list.each do |product|
      if product.discount_formula == ""
        sum += product.price * basket[product.product_code]
      else
        price = product.price
        quantity = basket[product.product_code]
        sum += eval product.discount_formula
      end
    end
    return sum
  end
  
  def initialize(args)
    @product_code = args[:product_code]
    @name = args[:name]
    @price = args[:price].to_f
    @discount_formula = args[:discount_formula]
    
    @@list << self
  end
end