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
    @order = Order.find(params[:id])
  end

  def destroy
    Order.find(params[:id]).destroy
    redirect_to(:action => 'index')
  end
  
  def checkout
    order = Order.find(params[:id])
    order.update_attributes(status: 'checkout')
    redirect_to order_path(order)
  end
  
  def authorize
    Order.find(params[:id]).update_attributes(billing_address: params[:order][:billing_address], shipping_address: params[:order][:shipping_address])
    str = Order.find(params[:id]).authorize(params[:Credit_card])
    flash[:notice] = str
    redirect_to orders_path()
  end

  def cancel
    Order.find(params[:id]).update_attributes(status: 'cancelled')
    redirect_to orders_path
  end

  private

  def order_params
    params.require(:order).permit(:billing_address, :shipping_address, :status)
  end
end
