require 'rails_helper'

RSpec.describe Category, :type => :model do
  let(:category) { FactoryGirl.create(:category) }
  let(:category_1) { FactoryGirl.create(:category, :category_with_empty_name) }
  let(:category_2) { FactoryGirl.create(:category, :category_with_no_thumurl) }

  it "Category name should not be empty" do
    expect(category.name).not_to be_empty
  end

  # negative test cases
  
  it "Category name should not contain numeric values" do
    expect(category.name).to be_a(String)
  end

  it "creating category without name should raise error" do
    expect{ category_1.save }.to raise_error( ActiveRecord::RecordInvalid )
  end
end
