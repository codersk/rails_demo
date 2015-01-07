class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  validates :product_id, :order_id, :qty, presence: true
  before_save :calculate_lineitem_total
  after_save :recalculate_order
  after_destroy :recalculate_order

  def calculate_lineitem_total
    self.unit_price ||= product.price
    self.tax = (self.unit_price * product.tax_rate/100) * self.qty
    self.total = (self.unit_price * self.qty) + self.tax
  end

  def recalculate_order
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
