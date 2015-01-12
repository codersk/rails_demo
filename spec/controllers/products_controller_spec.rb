require 'rails_helper'

RSpec.describe ProductsController, :type => :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:product) { FactoryGirl.create(:product) }
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
    end

    it 'Edit product' do
      get :edit, :id => product.id
      expect(assigns(:product).id).to eq(product.id)
    end

    it 'Update product' do
      put :edit, :id => product.id, :product => product.product_name
      expect(assigns(:product).id).to eq(product.id)
      expect(response.status).to eq(200)
    end

    it 'Delete product' do
      get :delete, :id => product.id
      expect(assigns(:product).id).to eq(product.id)
      expect(response.status).to eq(200)
    end

    it 'Product add to cart' do
      post :add_to_cart, :id => product.id, :qty => { :values => 1 }
      expect(response).to redirect_to order_path(product.line_items[0].order_id)
      expect(response.status).to eq(302)
    end

    it 'product image should be attached' do
      expect(product).to have_attached_file(:product_image)
    end

    it 'allows image to be removed from product' do
      put :edit, :id => product.id, :product => product.product_name
      expect(product.product_image.exists?).to eq(false)
      # expect(product.product_image).to eq(200) if product.image_delete == 1
    end

    it 'product image is should be of type jpeg or gif' do
      expect(product).to validate_attachment_content_type(:product_image)
        .allowing('image/jpg', 'image/jpeg', 'image/gif').rejecting('text/plain', 'text/xml')
    end
  end
end
