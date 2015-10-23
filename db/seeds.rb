puts "Associate id: "
associate = gets.chomp
puts "Tag: "
tag = gets.chomp
puts "Key: "
key = gets.chomp
fet = ProductsHelper::AmazonProductQuery.new(associate)
fet.set_credential(tag, key)

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

