class Order < ActiveRecord::Base
  has_many :line_items
  belongs_to :user

  validates :status, :user_id, presence: true
  validates :status, inclusion: { in: %w(cart checkout payment_complete cancelled) }
  validates_presence_of :billing_address, :shipping_address, :if => lambda { |o| o.status == 'checkout' }

  after_initialize do |order|
    self.status ||= 'cart'
    self.subtotal ||= 0
    self.total ||= 0
  end

  def recalculate_order
    self.total = 0.0
    self.subtotal = 0.0
    self.tax = 0.0
    line_items.each do |x|
      self.subtotal += x.unit_price * x.qty
      self.tax += x.tax
    end
    self.total += self.subtotal + ( self.subtotal * self.tax/100 )
    self.save!
  end

  def order_cancel
    self.status = 'cancelled'
    self.save!
  end
end
