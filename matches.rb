require 'jsonl'

# make json objects into arrays of ruby hashes
listings_file = File.read('data/listings.txt')
listings = JSONL.parse(listings_file)
products_file = File.read('data/products.txt')
products = JSONL.parse(products_file)
puts "listings: #{listings.count}"
puts "products: #{products.count}"
# set up results array

# find matches and add them to results array
  # loop over each product
  # create a hash for each product with key product_name and key listings as empty array
  # compare each product to each listing (another loop)
    # check for manufacturer match
    # if manufacturer matches, check for if product lists family
      # if product lists family then check for family matches
        # if family match then check model number matches
        # if model number matches, find product in results and add listing to listings
    # if no family, check for model number matches
      # if model number matches, find product in results and add listing to listings

# convert results to json and write to file
