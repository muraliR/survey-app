# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


unless User.find_by_email("murali").present?
	user = User.new(email: "murali@gmail.com", password: "hello123", password_confirmation: "hello123", role: "admin", authentication_token: Devise.friendly_token(length = 20))
	user.save!
end

unless User.find_by_email("krishna").present?
	user = User.new(email: "krishna@gmail.com", password: "hello123", password_confirmation: "hello123", role: "taker", authentication_token: Devise.friendly_token(length = 20))
	user.save!
end