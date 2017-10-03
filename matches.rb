require 'jsonl'
require 'pry'

# make json objects into arrays of ruby hashes
listings_file = File.read('data/listings.txt')
listings = JSONL.parse(listings_file)
products_file = File.read('data/products.txt')
products = JSONL.parse(products_file)
puts "listings: #{listings.count}"
puts "products: #{products.count}"

# set up results array
results = []

# find matches and add them to results array

# loop over each product
products.each do | product |
# create a hash for each product with key product_name and key listings as empty array
  product_hash = {}
  product_hash[:product_name] = product["product_name"]
  product_hash[:listings] = []
# compare each product to each listing (another loop)
  listings.each do | listing |
  # check for manufacturer match
    if listing["manufacturer"].downcase.include?(product["manufacturer"].downcase)
      # if manufacturer matches, check for if product lists family
      if product["family"] && listing["title"].downcase.include?(product["family"].downcase)
        # if family match then check model number matches
        if listing["title"].downcase.include?(" #{product["model"].downcase} ")
          # if model number matches, find product in results and add listing to listings
          product_hash[:listings] << listing
        end
      # if no family, check for model number matches
      elsif !product["family"]
        if listing["title"].downcase.include?(" #{product["model"].downcase} ")
          # if model number matches, find product in results and add listing to listings
          product_hash[:listings] << listing
        end
      end
    end
  end
  results << product_hash
end
puts results[0]

# convert results to json and write to file
File.open('results/matches.txt', 'a+') do |f|
  while results.count > 0
    line = results.pop
    f.write(line.to_json)
    f.write("\n")
  end
end
