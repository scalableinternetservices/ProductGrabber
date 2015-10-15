class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
    	t.string :name
    	t.string :origin
    	t.string :asin
    	t.decimal :rating
    	t.text :info
    	t.integer :price
    	t.timestamps
    end
  end
end
