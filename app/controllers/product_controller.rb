class ProductController < ApplicationController
	def index
		fet = ProductHelper::AmazonProductQuery.new("fasthall-20")
		fet.set_credential("AKIAJIO5ZZVUB6DZXK4Q", "6DjHhRTJbHLcuWz6oB6ehTNXffTW+lbrpgooEs1q")
        @products = fet.search("laptop")
	end
end