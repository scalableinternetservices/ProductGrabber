class AddLikeToFavorites < ActiveRecord::Migration
  def change
    add_column :favorites, :like, :integer, default: 1
  end
end
