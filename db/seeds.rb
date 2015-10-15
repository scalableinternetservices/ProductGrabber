# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
p1 = Product.create([{name: 'Sample1', 
					origin:'http://www.amazon.com/B001AMHWP8',
    				asin:'B001AMHWP8',
    				rating:4.5,
    				info:"Macbook Air",
    				price:1099},
    				{name: 'Sample2', 
					origin:'http://www.amazon.com/B001AMHWP8',
    				asin:'B001AMHWP10',
    				rating:4.5,
    				info:"Windows XP",
    				price:1099},
    				{name: 'Sample3', 
					origin:'http://www.amazon.com/B001AMHWP8',
    				asin:'B001AMHWP8',
    				rating:5.0,
    				info:"Macbook Air",
    				price:899}])