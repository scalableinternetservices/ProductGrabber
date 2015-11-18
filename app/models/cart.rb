class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  belongs_to :user

  attr_accessor :items
  @@mode=0
  @@count=0

  def get_items(items)
    @@items=items
  end

  def items
    @@items
  end

  def category
    line_items.group_by{|item| item.product.category}
  end

  def get_re_products(products)

    @@products=Array.new

    if products.nil?
      @@products=products
    else

      if products.count<7
        @@products=products
      else
        @temp=products.sort{|a,b| a.price <=> b.price}
        @count=-1

        @temp.each do |p|

          if(@count.eql? 7)
            break
          end

          if line_items.find_by_product_id(p.id)
            next
          else
            @count=@count+1
            @@products[@count]=p
          end

        end

      end

    end
  end

  def products
    @@products
  end

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

  def count
    @@count=@@count+1
  end

  def count_load(count)
    @@count=count
  end

end
