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
      flash[:notice] = "Product added successfully!"
      redirect_to(:action => 'index')
    else
      flash[:alert] = "All fields are mandetory!"
      render('new')
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if params["product"]["image_delete"].to_i == 1
      @product.image = nil
    end
    if @product.update_attributes(product_params)
      flash[:notice] = "Product updated successfully!"
      redirect_to(:action => 'show', :id => @product.id)
    else
      flash[:alert] = "All fields are mandetory!"
      render('index')
    end
  end

  def delete
    @product = Product.find(params[:id])
  end
  
  def destroy
    Product.find(params[:id]).destroy
    flash[:alert] = "Product deleted successfully!"
    redirect_to(:action => 'index')
  end

  def add_to_cart
    if order = Product.find(params[:id]).add_new_item(current_user, params[:qty].values[0].to_i)
      flash[:notice] = "Product added to cart"
      redirect_to order_path(order)
    else
      flash[:alert] = "Opps! something went wrong. Try again"
      redirect_to products
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :category_id, :tax_rate, :image)
  end
end
