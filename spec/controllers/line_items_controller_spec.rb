require 'rails_helper'

RSpec.describe LineItemsController, :type => :controller do
  let(:line_item) { FactoryGirl.create(:line_item) }

  it "remove line_item" do
    get :delete, :id => line_item.id
    expect(assigns(:line_item).id).to eq(line_item.id)
    expect(response.status).to eq(200)
  end

  it "update line_item" do
    post :update_quantity, :id => line_item.id, :line_item => { :qty => 3 }
    expect(assigns(:line_item).id).to eq(line_item.id)
    # expect(subject).to redirect_to order_path(line_item.id)
    expect(response.status).to eq(200)
  end

end
