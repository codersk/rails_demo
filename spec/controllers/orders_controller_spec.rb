require 'rails_helper'

RSpec.describe OrdersController, :type => :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:order) { FactoryGirl.create(:order, user: user) }
  before do
    sign_in user
  end

  describe 'GET index' do

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

    it 'Create new order' do
      order = Order.new
      get :new
      expect(assigns(:order).id).to eq(order.id)
      expect(response.status).to eq(200)
    end

    it 'Edit order' do
      get :edit, :id => order.id
      expect(assigns(:order).id).to eq(order.id)
      expect(response).to render_template('edit')
    end

    it 'Delete order' do
      get :delete, :id => order.id
      expect(assigns(:order).id).to eq(order.id)
    end
  end
end
