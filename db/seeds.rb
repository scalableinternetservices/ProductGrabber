fet = ProductsHelper::AmazonProductQuery.new("fasthall-20")
fet.set_credential("AKIAJTGFNOEB5LKAVPIQ", "/MjOeKIsLCxyJSc2pz1QjQ0hsW21QanNMTJe9wHf")

Rails.root.join('db', 'dict')
dict = File.open(Rails.root.join("db", "dict"), "r")
Product.delete_all
dict.each_line do |line|
	puts line
	sleep 3
	items = fet.search(line)
	items.each do |i|
		Product.create! :name => i.title, :price => i.price[1..-1].to_f, :description => i.url, :photo_file_name => i.image[2]
	end
end

