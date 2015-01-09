class CategoriesController < ApplicationController
  def index
    @categories = Category.all 
  end

  def show
    @category = Category.find(params[:id])
    @products = @category.products
  end

  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category added successfully!"
      redirect_to(:action => 'index')
    else
      flash[:alert] = "All fields are mandetory!"
      render('new')
    end
  end

  def edit
    @category = Category.find(params[:id])
  end
  
  def update
    @category = Category.find(params[:id])
    if params["category"]["image_delete"].to_i == 1
      @category.delete_image
    end
    if @category.update_attributes(category_params)
      flash[:notice] = "Category updated successfully!"
      redirect_to(:action => 'index', :id => @category.id)
    else
      flash[:alert] = "All fields are mandetory!"
      redirect_to(:action => 'index')
    end
  end

  def delete
    @category = Category.find(params[:id])
  end
  
  def destroy
    Category.find(params[:id]).destroy
    flash[:alert] = "Category deleted successfully!"
    redirect_to(:action => 'index')
  end
  
  private

  def category_params
    params.require(:category).permit(:name, :category_image)
  end
end
