# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Product.delete_all
Product.create! id: 1, name: "Smart Hub", price: 49.99, active: true
Product.create! id: 2, name: "Motion Sensor", price: 24.99, active: true
Product.create! id: 3, name: "Wireless Camera", price: 99.99, active: true
Product.create! id: 4, name: "Smoke Sensor", price: 19.99, active: true
Product.create! id: 5, name: "Water Leak Sensor", price: 14.99, active: true

OrderStatus.delete_all
OrderStatus.create! id: 1, name: "In Progress"
OrderStatus.create! id: 2, name: "Placed"
OrderStatus.create! id: 3, name: "Shipped"
OrderStatus.create! id: 4, name: "Cancelled"

Promotion.delete_all
Promotion.create! id: 1, name: "20%OFF", code: "PERCENT20OFF", value: 20.00, promo_type: "percent", conjunction: false
Promotion.create! id: 2, name: "5%OFF", code: "PERCENT5OFF", value: 5.00, promo_type: "percent", conjunction: true
Promotion.create! id: 3, name: "20POUNDSOFF", code: "FLAT20OFF", value: 20.00, promo_type: "flat", conjunction: true