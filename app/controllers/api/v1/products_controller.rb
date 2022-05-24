class Api::V1::ProductsController < ApiBaseController
  include ProductsDocs
  def index
    @products = Product.all
  end
end
