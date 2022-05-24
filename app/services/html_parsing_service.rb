require 'open-uri'
class HtmlParsingService
  attr_accessor :headers
  def initialize(url,options={})
    @uri = URI url
    @headers = options[:headers] || { "User-Agent"=>USER_AGETS.sample,
      "Accept"=>"text/html"
    } #we can add more options in default headers
  end

  def get_products(products=[])
    document = Nokogiri::HTML(open(@uri, headers)) #get nokogiri document
    document.css(".s-result-item").each do |search_result_item| #all items are in this section there is an empty section as well 
      unless search_result_item.attr("data-asin").blank?
        parsed_product = parse_product(search_result_item)
        products <<  parsed_product unless parsed_product.blank? #Append products
      end
    end
    if document.at("li.a-last a")#(Pagination) next page link selector
      #Parse all pages of result
      @uri = URI @uri.scheme + "://"+@uri.host+document.at("li.a-last a").attr("href")
      get_products(products) #Recursively call and append products
    end
    products
  end

  def parse_product(search_result_item)
    begin
      #For test purpose avoid nil class method
      {
        name: search_result_item.at(".a-text-normal")&.text&.strip,
        asin: search_result_item.attr("data-asin")&.strip,
        image: search_result_item.css("img").attr("src")&.value&.strip,
        price: search_result_item.css(".a-offscreen")&.text&.strip,
        customer_review: search_result_item.at(".a-size-small span")&.text&.strip,
        customer_review_count: search_result_item.at("span.a-size-base")&.text.to_s.gsub(",","").to_i,
        url: @uri.scheme + "://"+@uri.host+search_result_item.at(".a-link-normal").attr("href"),
        shipping_message: search_result_item.at(".a-color-secondary span")&.text,
        is_prime: false
      }
    rescue => e
      #TODO a notification service with backtrace should be implemented here just to check if DOM is changed
    end
  end
end
