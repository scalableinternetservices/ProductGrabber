User.delete_all

for i in 1..1000 do
user = User.create!(
name: "user"+"#{i}",
email: "user"+"#{i}"+"@gmail.com",
password: "123456",
password_confirmation: "123456"
)

user.cart=Cart.create
user.cart.get_items(nil)

end
