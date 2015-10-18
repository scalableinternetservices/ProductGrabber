class Product < ActiveRecord::Base
  has_attached_file :photo
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  validates :name, presence: true
  validates :description, presence: true
  validates :photo, presence: true
  
	searchable do
	    text :name, :boost => 2
	    text :description
	    double :price
	end
end
