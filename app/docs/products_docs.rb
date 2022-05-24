module ProductsDocs
  extend Apipie::DSL::Concern
  def_param_group :success do
    property :products, :array_of => Hash do
      property :name, String
      property :price, Integer
      property :customer_review, String
      property :customer_review_count, String
      property :shipping_message, String
      property :asin, String
      property :image, String
      property :url, String
      property :is_prime, String
    end
  end
  error 403, "Unauthenticated", meta:{
    error: "Invalid token",
  }
  api :GET, "/products", "To get list of all products which are scrapped"
  returns :success
  def index
    super
  end

end