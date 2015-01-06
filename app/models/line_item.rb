class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  validates :product_id, :order_id, :qty, presence: true
  before_save :calculate_lineitem_total
  after_save :recalculate_order
  after_destroy :recalculate_order

  # def calculate_lineitem_total
  #   p = Product.find(self.product_id)
  #   if p.price.nil?
  #     puts "Product Price not available"
  #   else
  #     self.unit_price ||= p.price
  #     self.total = (self.unit_price + ((self.unit_price * self.tax)/100) )* self.qty
  #   end
  # end

  def calculate_lineitem_total
    self.unit_price ||= product.price
    self.total = ( self.unit_price + (self.unit_price * self.tax/100) )* self.qty
  end

  def recalculate_order
    # self.order
    order.recalculate_order
  end

  def update_quantity(new_qty)
    self.qty = new_qty
    self.save
    order
  end

  def delete
    self.destroy
    order
  end
end
