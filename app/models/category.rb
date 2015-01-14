class Category < ActiveRecord::Base
  include Image
  has_many  :products
  
end
