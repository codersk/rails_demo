class Product < ActiveRecord::Base
  belongs_to  :category
  has_many  :line_items

  validates :product_name, :category_id, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :tax_rate, numericality: { greater_than_or_equal_to: 0 }
  validates :thumburl, format:{ with: URI::regexp( %w(http https) )}

  def add_item(product_id)
    item = items.where('product_id = ?', product_id).first
    if item
      # increase the quantity of product in cart
      item.quantity + 1
      save
    else
      # product does not exist in cart
      cart.items << Item.new(product_id: product_id, quantity: 1)
    end
    save
  end

  def add_new_item(current_user, qty)
    if Order.find_by(user_id: current_user.id) && Order.where(status: 'cart') 
      LineItem.create(order_id: Order.find_by(user_id: current_user.id).id , product_id: id, qty: qty['value'].to_i , tax: tax_rate)
    else
      Order.create( Billing_address: "BEML", shipping_address: "BTM", user_id: current_user.id)
    end
  end
end
