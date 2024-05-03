# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# Création des utilisateurs
# Create some users
User.create(email: 'test1@example.com', encrypted_password: 'azerty')
User.create(email: 'user2@example.com', encrypted_password: 'password2')
p "creation user..."
# Create some products
Product.create(name: 'Product 1', year: '2022', price: 100, description: 'Description 1', adress: 'Adress 1', user_id: 1)
Product.create(name: 'Product 2', year: '2023', price: 150, description: 'Description 2', adress: 'Adress 2', user_id: 2)
p "creation produits..."
# Create some bookings
Booking.create(accepted: true, date: Date.today, user_id: 1, product_id: 1)
Booking.create(accepted: false, date: Date.tomorrow, user_id: 2, product_id: 2)
p "creation réservations..."
