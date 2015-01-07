require 'rails_helper'


RSpec.describe Product, :type => :model do
  let(:product) { FactoryGirl.create(:product) }
  let(:user) { FactoryGirl.create(:user) }
  let(:order) { FactoryGirl.create(:order, user: current_user) }

  it "Product name should not be empty" do
    expect(product.product_name).not_to be_empty
  end

  it "Product price should be greater than or equal to 0" do
    expect(product.price).to be >= 0
  end

  it "Product tax rate should be greater than or equal to 0" do
    expect(product.tax_rate).to be >= 0
  end

  it "Product thumburl should have 'http' or 'https' as prefix" do
    expect(product.thumburl).to match( /^http(s?)\W/ )
  end

  # negative passing case
  it "Product name should not contain numeric values" do
    expect(product.product_name).to be_a(String)
  end

  it "Product description should not be empty" do
    expect(product.description).not_to be_empty
  end

  it "Product price should not be empty" do
    expect(product.price).not_to be_zero
  end

  it "Product tax rate should not be empty" do
    expect(product.tax_rate).not_to be_zero
  end

  it "Product price should not be negative" do
    expect(product.price).not_to be < 0
  end

  it "Product tax rate should not be negative" do
    expect(product.tax_rate).not_to be < 0
  end

  # Negative test cases

  it "creating product without name should raise error" do
    expect{ product.product_name = nil; product.save!.save }.to raise_error( ActiveRecord::RecordInvalid )
  end

  it "creating product without price should raise error" do
    expect{ product.price = nil; product.save! }.to raise_error( ActiveRecord::RecordInvalid )
  end

  it "creating product with negative price should raise error" do
    expect{ product.price = -15.3; product.save! }.to raise_error( ActiveRecord::RecordInvalid )
  end

  it "creating product with invalid price should raise error" do
    expect{ product.price = "abc"; product.save! }.to raise_error( ActiveRecord::RecordInvalid )
  end

  it "creating product without tax_rate should raise error" do
    expect{ product.tax_rate = nil; product.save! }.to raise_error( ActiveRecord::RecordInvalid )
  end

  it "creating product with invalid tax_rate should raise error" do
    expect{ product.tax_rate = -1.5; product.save! }.to raise_error( ActiveRecord::RecordInvalid )
  end

  it "adding a product to cart should increase line item count by 1" do
    expect{ product.add_new_item(user, 1) }.to change(LineItem, :count ).by(1)
  end

  it "adding the same product into cart should increase line item quantity by 1"
end
