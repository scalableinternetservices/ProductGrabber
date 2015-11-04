require 'bcrypt'

class User < ActiveRecord::Base

  has_many :favorites, dependent: :destroy

  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  def like_product(product_id)
    current_fav = favorites.find_by_product_id(product_id)
    if current_fav
      current_fav.like += 1
    else
      current_fav = favorites.build(product_id: product_id)
      current_fav.like = 1;
    end
    current_fav
  end

  def find_product(product_id)
    if favorites.find_by_product_id(product_id)
      true
    else
      false
    end
  end

end
