require 'rails_helper'

RSpec.describe LineItem, :type => :model do
  let(:lineitem) { FactoryGirl.create(:lineitem) }

  it "LineItem shoud have product id" do
    expect(lineitem.product_id).not_to be_zero
  end

  it "LineItem shoud have order id" do
    expect(lineitem.order_id).not_to be_zero
  end
  
  it "LineItem shoud have quantity" do
    expect(lineitem.qty).not_to be_zero
  end
end
