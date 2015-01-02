class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to(:action => 'index')
    else
      render('new')
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
      redirect_to(:action => 'show', :id => @product.id)
    else
      render('index')
    end
  end

  def delete
    @product = Product.find(params[:id])
  end
  
  def destroy
    Product.find(params[:id]).destroy
    redirect_to(:action => 'index')
  end

  def add_to_cart
    product = Product.find(params[:id]).add_new_item(current_user, params[:qty])
    redirect_to order_path(product.order_id)
  end

  private

  def product_params
    params.require(:product).permit(:product_name, :description, :price, :thumburl, :category_id, :tax_rate)
  end
end