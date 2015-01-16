class LineItemsController < ApplicationController
  def new
    @line_item = LineItem.new
  end
  
  def create
    @line_item = LineItem.new(line_item_params)
    if @line_item.save
      redirect_to(:action => 'index')
    else
      render('new')
    end
  end

  def edit
    @line_item = LineItem.new(params[:id])
  end
  
  def update
    line_item_updated = LineItem.find(params[:id]).update_quantity(params['line_item']['qty'].to_i)
    redirect_to order_path( LineItem.find(params[:id]).order_id)
  end

  def delete
    @line_item = LineItem.find(params[:id])
  end

  def destroy
    order_id = LineItem.find(params[:id]).order_id
    LineItem.find(params[:id]).destroy
    redirect_to order_path( order_id )
  end

  private

  def line_item_params
    params.require(:order).permit(:order_id, :product_id, :unit_price, :qty, :tax, :total)
  end
end
