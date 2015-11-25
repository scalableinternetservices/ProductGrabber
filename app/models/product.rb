class Product < ActiveRecord::Base

  has_many :line_items
  before_destroy :ensure_not_referenced_by_any_line_item
  has_many :favorites
  before_destroy :ensure_not_referenced_by_any_favorite

  has_attached_file :photo
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  validates :name, presence: true
  validates :description, presence: true
  validates :photo, presence: true
  
	#searchable do
	#    text :name, :boost => 2
	#    text :description
	#    double :price
  #end

  private
  # ensure that there are no line items referencing this product
  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, 'Line Items present')
      return false
    end
  end

  def ensure_not_referenced_by_any_favorite
    if favorites.empty?
      return true
    else
      errors.add(:base, 'Favorites present')
      return false
    end
  end


end
