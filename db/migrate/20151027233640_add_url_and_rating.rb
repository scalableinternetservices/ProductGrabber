class AddUrlAndRating < ActiveRecord::Migration
  def change
    add_column :products, :url, :string
    add_column :products, :rating, :float
  end
end
