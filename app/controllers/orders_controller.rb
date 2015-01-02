class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @line_items = @order.line_items
  end

  def new
    @order = Order.new
  end
  
  def create
    @order = Order.new(order_params)
    binding.pry
    if @order.save
      redirect_to(:action => 'index')
    else
      render('new')
    end
  end

  def edit
    @order = Order.find(params[:id])
  end
  
  def update
    @order = Order.find(params[:id])
    if @order.update_attributes(order_params)
      redirect_to(:action => 'edit', :id => @order.id)
    else
      render('index')
    end
  end

  def delete
    binding.pry
    @order = Order.find(params[:id])
  end

  def destroy
    binding.pry
    Order.find(params[:id]).destroy
    binding.pry
    redirect_to(:action => 'index')
  end

  def cancel
    Order.find(params[:id]).order_cancel
    redirect_to(:action => 'index')
  end

  private

  def order_params
    params.require(:order).permit(:billing_address, :shipping_address, :status)
  end
end
