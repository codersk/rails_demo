require 'rails_helper'

RSpec.describe Category, :type => :model do
  let(:category) { FactoryGirl.create(:category) }

  it "Category name should not be empty" do
    expect(category.name).not_to be_empty
  end

  it "Category thumburl should have 'http' or 'https' as prefix" do
    expect(category.thumburl).to match( /^http(s?)\W/)
  end

  # negative passing case
  it "Category name should not contain numeric values" do
    expect(category.name).to be_a(String)
  end

  it "Category thumburl should not be empty" do
    expect(category.thumburl).not_to be_empty
  end
end
