require 'rails_helper'

RSpec.describe CategoriesController, :type => :controller do
  
  describe 'GET index' do

    it 'list categories' do
      category = Category.all
      get :index
      expect(assigns(:categories)).to eq(category)
      binding.pry
    end

    it 'render index page template' do
      get :index
      expect(response).to render_template('index')
    end

    it "It should have 200 status" do
      expect(response.status).to eq(200)
    end

    it 'Create new category' do
      category = Category.new
      get :new
      expect(assigns(:category).id).to eq(category.id)
      expect(response.status).to eq(200)
    end

    it 'Edit category' do
      get :edit, :id => 1
      expect(assigns(:category).id).to eq(1)
      expect(response).to render_template('edit')
    end

    it 'Edit category' do
      put :edit, :id => 1, :category => "Electronics"
      expect(assigns(:category).id).to eq(1)
      expect(response).to render_template('index')
    end

    it 'Delete category' do
      get :delete, :id => 1
      expect(assigns(:category).id).to eq(1)
    end
  end
end
