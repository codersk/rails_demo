require 'rails_helper'

RSpec.describe ProductsController, :type => :controller do
  let(:user) { FactoryGirl.create(:user) }
  before do
    sign_in user
  end
  
  describe 'GET index' do

    it 'list products' do
      products = Product.all
      get :index
      expect(assigns(:products)).to eq(products)
    end
    
    it 'render index page template' do
      get :index
      expect(response).to render_template('index')
    end

    it "It should have 200 status" do
      expect(response.status).to eq(200)
    end

    it 'Create new product' do
      product = Product.new
      get :new
      expect(assigns(:product).id).to eq(product.id)
      expect(response.status).to eq(200)
      binding.pry
    end

    it 'Edit product' do
      get :edit, :id => 4
      expect(assigns(:product).id).to eq(4)
    end

    it 'Edit product' do
      put :edit, :id => 4, :product => "Plant"
      expect(assigns(:product).id).to eq(4)
    end

    it 'Delete product' do
      get :delete, :id => 4
      expect(assigns(:product).id).to eq(4)
    end

    it 'Product add to cart' do
      post :add_to_cart, :id => 956
      expect(assigns(:product).id).to eq(4)
    end
  end
end
