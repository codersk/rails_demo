require 'rails_helper'

RSpec.describe CategoriesController, :type => :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:category) { FactoryGirl.create(:category) }
  before do
    sign_in user
  end

  describe 'GET index' do

    it 'list categories' do
      category = Category.all
      get :index
      expect(assigns(:categories)).to eq(category)
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
      get :edit, :id => category.id
      expect(assigns(:category).id).to eq(category.id)
      expect(response).to render_template('edit')
    end

    it 'Delete category' do
      get :delete, :id => category.id
      expect(assigns(:category).id).to eq(category.id)
    end

    it 'allows image to be added to category' do
      expect(category).to have_attached_file(:image)
    end

    it 'allows image to be removed from category' do
      put :edit, :id => category.id, :category => category.id
      expect(category.image.exists?).to eq(false)
    end

    it 'category image is should be of type jpeg or gif' do
      expect(category).to validate_attachment_content_type(:image)
        .allowing('image/jpg', 'image/jpeg', 'image/gif').rejecting('text/plain', 'text/xml')
    end
  end
end
