class Product < ActiveRecord::Base
  include Image

  belongs_to  :category
  has_many  :line_items

  validates :category_id, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :tax_rate, numericality: { greater_than_or_equal_to: 0 }

  def add_item(product_id)
    item = items.where('product_id = ?', product_id).first
    if item
      item.quantity + 1
      save
    else
      cart.items << Item.new(product_id: product_id, quantity: 1)
    end
    save
  end

  def add_new_item(current_user, qty)
    order =  Order.find_by(user_id: current_user.id, status: 'cart')
    if order
      li = order.line_items.find_by(product_id: id)
      if li
        li.update_quantity( li.qty + qty )
      else
        LineItem.create(order_id: order.id , product_id: id, qty: qty , tax: tax_rate)
      end
      return order
    else
      Order.create( billing_address: "BEML", shipping_address: "BTM", user_id: current_user.id)
      add_new_item(current_user, qty)
    end
  end
  
  def authorize (credit_card)
    if credit_card[:card_number] != ""
      self.status = 'payment_complete'
      self.save
      msg = "Card Details\n Number: " + credit_card[:card_number] +"\n Expairy Date: " + credit_card[:expiry_date] + "\nCVV: " + credit_card[:cvv]
    else
      "All fields are requaired!"
    end
  end
end
