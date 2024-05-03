class ProductsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @products = Product.all
  end

  private

  def stuff_params
    params.require(:product).permit(:name, :price, :adress, description:, photos: [] )
  end
end
