class Api::V1::AmazonSerpsController < ApiBaseController
  include AmazonSerpsDocs
  before_action :set_amazon_serp, only: [:show, :update, :destroy]
  def index
    #we need to show all the column we do not have created_at and updated_at
    @amazon_serps = AmazonSerp.all
  end
  
  def create
    @amazon_serp = AmazonSerp.new(amazon_serp_params)
    if @amazon_serp.save
      render template: "/api/v1/amazon_serps/show"
    else
      render json: {errors: @amazon_serp.errors.full_messages}, status: 422
    end
  end

  def update
    if @amazon_serp.update(amazon_serp_params)
      render template: "/api/v1/amazon_serps/show"
    else
      render json: {errors: @amazon_serp.errors.full_messages}, status: 422
    end
  end

  def show
  end

  def destroy
    if @amazon_serp.destroy
      render json: {message: "Page successfully deleted"}
    else
      render json: {errors: @amazon_serp.errors.full_messages}, status: 422
    end
  end
  private
  def set_amazon_serp
    @amazon_serp = AmazonSerp.find params[:id]
  end

  def amazon_serp_params
    params.require(:amazon_serp).permit(:parsed_at, :url, :active)
  end
end
