class CrawlJob < ApplicationJob
  queue_as :crawl_amazone_sarech
  retry_on Net::OpenTimeout, Timeout::Error, wait: :exponentially_longer, attempts: 2 # retry if gets a timeout issue
  retry_on SocketError, wait: :exponentially_longer, attempts: 2 # retry if internet is slow or not working

  def perform(amazon_serp)
    url = amazon_serp.url
    Rails.logger.info "Job started to get products from #{url}"
    products = ProxyCrawlerService.new(url).get_products #using proxy crawler
    products = HtmlParsingService.new(url).get_products(products) #Parse from page and append result
    create_products(products)
    amazon_serp.update(parsed_at: DateTime.now)
  end

  def create_products(products)
    new_products = []
    products.compact.each do |product|
      existing_product = Product.find_by_asin(product[:asin]) #update if product is already create
      if existing_product
        #update product if its already exists
        product.each do |key, value|
          existing_product.send("#{key}=",value)
        end
        existing_product.save #only will run query if something is changed
      else
        temp_product = {}
        product.each do |key, value|
          temp_product[key] = value
        end
        new_products << temp_product
      end
    end
    Product.upsert_all(new_products) unless new_products.blank?
  end
end
