require 'rails_helper'

RSpec.describe Order, :type => :model do
  let(:order) { FactoryGirl.create(:order) }
  let(:order_1)  { FactoryGirl.create(:order, :order_1) }
  
  it "Order billing_address should not be empty" do
    expect(order.billing_address).not_to be_empty
  end

  it "Order shipping_address should not be empty" do
    expect(order.shipping_address).not_to be_empty
  end

  it "Order status can be either cart, checkout, payment_complete or cancelled" do
    expect(order.status).to match( /(cart|payment_complete|checkout|cancelled)/ )
  end
  
  # negative test cases

  it "Calculates order totals should be 0.00 when there are no items" do
    if order_1.line_items.count == 0
      expect(order_1.total).to eq(0.0)
    end
  end

  it "Calculates the totals correctly (subtotal, tax, total) for the order when there is exactly 1 item" do
    line_item = FactoryGirl.create(:line_item, order: order)

    if order.line_items.count == 1
      expect(order.subtotal).to eq(line_item.unit_price * line_item.qty )
      expect(order.tax).to eq(line_item.tax)
      expect(order.total).to eq(line_item.total)
    end
  end

  it "Calculates the totals correctly (subtotal, tax, total) for the order when there is more than 1 item" do
    line_item = FactoryGirl.create(:line_item, order: order)
    line_item2 = FactoryGirl.create(:line_item, order: order)
    line_item2.qty = 1
    order.line_items.push(line_item2)
    order.recalculate_order
    if order.line_items.count > 1
      subtotal = tax = total = 0
      order.line_items.each do |l|
        subtotal += l.unit_price * l.qty
        tax += l.tax
        total += l.total
      end
      expect( [order.subtotal, order.tax, order.total] ).to eq([subtotal, tax, total])
    end
  end

  it "Cancels the Order correctly"
end
