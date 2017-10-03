require 'jsonl'

listings_file = File.read('data/listings.txt')
listings = JSONL.parse(listings_file)
products_file = File.read('data/products.txt')
products = JSONL.parse(products_file)

results = []

products.each do | product |

  product_hash = {}
  product_hash[:product_name] = product["product_name"]
  product_hash[:listings] = []

  listings.each do | listing |
    if listing["manufacturer"].downcase.include?(product["manufacturer"].downcase)
      if product["family"] && listing["title"].downcase.include?(product["family"].downcase)
        if listing["title"].downcase.include?(" #{product["model"].downcase} ")
          product_hash[:listings] << listing
        end
      elsif !product["family"]
        if listing["title"].downcase.include?(" #{product["model"].downcase} ")
          product_hash[:listings] << listing
        end
      end
    end
  end

  results << product_hash

end

if File.exist?('results/matches.txt')
  File.delete('results/matches.txt')
end

File.open('results/matches.txt', 'a+') do |f|
  while results.count > 0
    line = results.pop
    f.write(line.to_json)
    f.write("\n")
  end
end
