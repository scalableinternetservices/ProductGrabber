class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  @@mode=0

  def sort_choice(mode)
    @@mode=mode
  end

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

  def sort_items
    if @@mode.eql? 0
      line_items.sort {|a,b| a.updated_at <=> b.updated_at}
    elsif @@mode.eql? 1
      line_items.sort {|a,b| a.product.favorites.count <=> b.product.favorites.count}.reverse
    else
      line_items.sort {|a,b| a.product.price <=> b.product.price}
    end
  end

end
