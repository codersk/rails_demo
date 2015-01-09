require 'rails_helper'

RSpec.describe OrdersController, :type => :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:order) { FactoryGirl.create(:order, user: user) }
  before do
    sign_in user
  end

  it 'list orders' do
    order = Order.all
    get :index
    expect(assigns(:orders)).to eq(order)
  end

  it 'render index page template' do
    get :index
    expect(response).to render_template('index')
  end

  it "It should have 200 status" do
    expect(response.status).to eq(200)
  end

  it "changes the order status to checkout" do
    post :checkout, :id => order.id
    expect(response).to redirect_to(controller: :orders, action: :show, id: order.id)
    expect(response.status).to eq(302)
  end

  it "cancel's the order and reidrect to orders index" do
    post :cancel, :id => order.id
    expect(response).to redirect_to(controller: :orders, action: :index)
    expect(response.status).to eq(302)
  end

  it "validate payment details" do
    post :validate, :id => order.id, :order => { billing_address: 'billing_address', shipping_address: 'shipping_address' }, :credit_card => { card_number:'123456', expiry_date: '12/12/2015', cvv: '123'}  
    expect(response).to redirect_to(controller: :orders, action: :index)
    expect(response.status).to eq(302)
  end
end
