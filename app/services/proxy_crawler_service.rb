class ProxyCrawlerService
  attr_accessor :url, :options, :headers
  SUCCESS_ORIGINAL_STATUSES = [200, 201, 204, 301] #we can find and add more from documentations
  SUCCESS_PC_STATUSES = [200]

  def initialize(url, options={})
    @url = url
    @headers = options[:headers] || { "User-Agent"=>USER_AGETS.sample } #we can add more options in default headers
  end

  def get_products
    scraper_api = ProxyCrawl::ScraperAPI.new(token: Rails.application.credentials.config.dig(:proxy_crawler, :normal_token))
    response = scraper_api.get(url, headers)
    response_body = JSON.parse response.body
    if SUCCESS_ORIGINAL_STATUSES.include?(response_body['original_status']) || SUCCESS_PC_STATUSES.include?(response_body['pc_status'])
      return parsed_products(response_body["body"]["products"])
    else
      Rails.logger.info "The proxy crawler failed with original_status=#{response_body["original_status"]} and pc_status=#{response_body["pc_status"]}"
      Rails.logger.info response_body["body"]
      return []
    end
  end

  def parsed_products(raw_products)
    columns = Product.column_names #To get only data for which we have column in database
    products = []
    raw_products.each do |product|
      temp_product = {}
      product.each do |key, value|
        temp_product[key.underscore.to_sym] = value if columns.include?(key.underscore)
      end
      products << temp_product
    end
    products
  end
end