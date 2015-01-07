require 'rails_helper'

RSpec.describe LineItem, :type => :model do
  let(:order) { FactoryGirl.create(:order) }
  let(:lineitem) { FactoryGirl.create(:line_item, order: order) }

  it "LineItem shoud have product id" do
    expect(lineitem.product_id).not_to be_zero
  end

  it "LineItem shoud have order id" do
    expect(lineitem.order_id).not_to be_zero
  end
  
  it "LineItem shoud have quantity" do
    expect(lineitem.qty).not_to be_zero
  end

  # negative test cases
  it "calculates the totals correctly (subtotal, tax, total) for the line item" do
    expect(lineitem.unit_price).to eq(lineitem.product.price)
    expect(lineitem.total).to eq((lineitem.product.price * lineitem.qty)+lineitem.tax)
  end

  it "Update the quantity correctly and recalculates the totals for the line item and order" do
    expect{ lineitem.update_quantity(3) }.to change{lineitem.total.round}.by(lineitem.unit_price)
    expect{ order.line_items[0].update_quantity(3) }.to change{order.subtotal.round}.by(lineitem.unit_price)
  end

  it "Deletes the line item and recalculates the totals for the order" do
    expect{ lineitem.delete }.to change{order.subtotal.round}.by(10)
  end
end
