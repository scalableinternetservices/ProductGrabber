class AddUrlAndRating < ActiveRecord::Migration
  def change
    add_column :products, :url, :text
    add_column :products, :rating, :float
  end
end
