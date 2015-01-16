class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @line_items = @order.line_items
  end
  
  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to(:action => 'index')
    else
      render('new')
    end
  end
  
  def update
    @order = Order.find(params[:id])
    if @order.update_attributes(order_params)
      redirect_to(:action => 'edit', :id => @order.id)
    else
      render('index')
    end
  end
  
  def checkout
    order = Order.find(params[:id])
    order.update_attributes(status: 'checkout')
    redirect_to order_path(order)
  end
  
  def validate
    Order.find(params[:id]).update_attributes(billing_address: params[:order][:billing_address], shipping_address: params[:order][:shipping_address])
    msg = Order.find(params[:id]).authorize(params[:credit_card])
    flash[:notice] = msg
    redirect_to orders_path()
  end

  def cancel
    Order.find(params[:id]).cancel
    redirect_to orders_path
  end

  private

  def order_params
    params.require(:order).permit(:billing_address, :shipping_address, :status)
  end
end
