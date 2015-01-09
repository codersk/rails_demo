require 'rails_helper'

RSpec.describe LineItemsController, :type => :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:order) { FactoryGirl.create(:order, user: user) }
  let(:line_item) { FactoryGirl.create(:line_item, order: order) }
  before do
    sign_in user
  end

  it "remove line_item" do
    get :delete, :id => line_item.id
    expect(assigns(:line_item).id).to eq(line_item.id)
    expect(response.status).to eq(200)
  end

  it "update line_item" do
    post :update, :id => line_item.id, :line_item => { :qty => 3 }
    expect(response.status).to eq(302)
    expect(response).to redirect_to("/orders/" + order.id.to_s) 
  end

end
