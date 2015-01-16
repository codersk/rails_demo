module Image
  extend ActiveSupport::Concern

  included do
    validates :name, presence: true

    has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/noimage.jpg"
    validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  end
  
  def image_delete
    @image_delete ||= "0"
  end
end
