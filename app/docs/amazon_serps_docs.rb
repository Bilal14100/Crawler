module AmazonSerpsDocs
  extend Apipie::DSL::Concern
  def_param_group :index_success do
    property :amazon_serps, :array_of => Hash do
      property :id, Integer
      property :url, String
      property :active, [true, false]
      property :parsed_at, String
    end
  end

  def_param_group :show_success do
    property :id, Integer
    property :url, String
    property :active, [true, false]
    property :parsed_at, String
  end

  def_param_group :deleted_success do
    property :message, String
  end

  def_param_group :create_or_update do
    param :amazon_serp, Hash, desc: '', required: true do
      property :url, String
      property :active, [true, false]
    end
  end


  error 403, "Unauthenticated", meta:{
    error: "Invalid token",
  }
  api :GET, "/amazon_serps", "To get list of all serps urls which are to be scrapped"
  returns :index_success
  def index
    super
  end

  api :GET, '/amazon_serps/:id', "Detail of an amazone serp"
  returns :show_success, "SERP is sucessfully found"
  def show
    super
  end

  api :DELETE, '/amazon_serps/:id', "Delete an amazone serp"
  returns :deleted_success, "SERP is sucessfully deleted"
  def destroy
    super
  end

  api :PUT, '/amazon_serps/:id', "it will update serp"
  param_group :create_or_update
  returns :show_success
  def update
    super
  end
end