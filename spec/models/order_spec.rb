require 'rails_helper'

RSpec.describe Order, :type => :model do
  let(:order) { FactoryGirl.create(:order) }
  
  it "Order billing_address should not be empty" do
    expect(order.billing_address).not_to be_empty
  end

  it "Order shipping_address should not be empty" do
    expect(order.shipping_address).not_to be_empty
  end

  it "Order status can be either cart, checkout, payment_complete or cancelled" do
    expect(order.status).to match( /(cart|payment_complete|checkout|cancelled)/ )
  end
end
