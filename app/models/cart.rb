class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy

  def add_product(product_id)
    current_item = line_items.find_by_product_id(product_id)
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(product_id: product_id)
      current_item.quantity = 1;
    end
    current_item
  end

  def sorted_by_price
    line_items.sort {|a,b| a.product.price <=> b.product.price}
  end

  def sorted_by_likes
    line_items.sort {|a,b| a.product.favorites.count <=> b.product.favorites.count}.reverse
  end

end
