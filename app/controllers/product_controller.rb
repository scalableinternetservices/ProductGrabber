class ProductController < ApplicationController
	def index
		fet = ProductHelper::AmazonProductQuery.new("")
		fet.set_credential("", "")
		@products = fet.search("laptop")
	end
end
