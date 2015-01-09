class Category < ActiveRecord::Base
  has_many  :products

  validates :name, presence: true
  validates :thumburl, format:{ with: URI::regexp( %w(http https) )}

  has_attached_file :category_image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/noimage.jpg"
  validates_attachment_content_type :category_image, :content_type => /\Aimage\/.*\Z/

  def image_delete
    @image_delete ||= "0"
  end

  def delete_image
    self.category_image = nil
  end
end
