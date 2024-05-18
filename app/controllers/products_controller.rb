class ProductsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :authenticate_user!, only: [:show, :create, :new]
  include Pundit


  def index
    @products = Product.where(reserved: false)
    authorize @products
  end

  def new
    @product = Product.new
    authorize @product
  end

  def create
    @product = Product.new(product_params)
    @product.user_id = current_user.id
    @product.photos.attach(params[:product][:photos])
    authorize @product
    if @product.save
      return redirect_to products_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @product = Product.find(params[:id])
    @booking = Booking.new
    @my_product_booked = Booking.joins(:product).where("products.user_id = ?", current_user.id)
    authorize @product
  end

  def edit
    @product = Product.find(params[:id])
    authorize @product
  end

  def update
    @product = Product.find(params[:id])
    authorize @product
    if @product.update(product_params)
    redirect_to products_path(@products), flash: {alert: "Le produit a été modifié avec succès"}
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    authorize @product
    @product.destroy
    redirect_to products_path, status: :see_other
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :adress, :description, :user_id, photos: [])
  end
end
