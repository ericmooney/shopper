require "pry"
require "httparty"

x = HTTParty.get("https://api.gilt.com/v1/products?q=jeans&store=women&apikey=923eb6ef6cc3801d98d68766a6debef0")

def parse_gilt_results(x)
  gilt_results = {}

  x["products"].each do |product|
    gilt_results[product["name"]] = {
      "brand" => product["brand"],
      "descriptions" => product["content"]["description"],
      "sale_price" => product["skus"][0]["sale_price"],
      "size" => product["skus"][0]["attributes"][0]["value"],
      "image" => product["image_urls"]["1080x1440"][0]["url"]
      }
  end
  gilt_results
end

g = parse_gilt_results(x)
binding.pry