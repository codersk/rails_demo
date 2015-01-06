require 'rails_helper'

RSpec.describe OrdersController, :type => :controller do
  let(:user) { FactoryGirl.create(:user) }
  describe 'GET index' do

    it 'list orders' do
      order = Order.all
      get :index
      expect(assigns(:orders)).to eq(order)
      binding.pry
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
      get :edit, :id => 5
      expect(assigns(:order).id).to eq(5)
      expect(response).to render_template('edit')
    end

    it 'Edit order' do
      put :edit, :id => 5
      expect(assigns(:order).id).to eq(5)
      expect(response).to render_template('edit')
    end

    it 'Delete order' do
      get :delete, :id => 5
      expect(assigns(:order).id).to eq(5)
    end
  end
end
