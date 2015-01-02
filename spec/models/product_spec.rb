require 'rails_helper'


RSpec.describe Product, :type => :model do
  let(:product) { FactoryGirl.create(:product, :product_1) }

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

end
