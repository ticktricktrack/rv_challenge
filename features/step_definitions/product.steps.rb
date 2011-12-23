Given /^the following products exist$/ do |product_table|
  Product.cleanup
  product_table.hashes.each do |hash|
    Product.new(hash)
  end
end

When /^the customer checks out "([^"]*)"$/ do |basket|
  #Count identical items
  @basket = Hash.new(0)
  basket.split(',').each do |item|
    @basket[item] += 1
  end
end

Then /^the expected price should be "([^"]*)"$/ do |expected_price|
  Product.total_price(@basket).should eql(expected_price.to_f)
end

