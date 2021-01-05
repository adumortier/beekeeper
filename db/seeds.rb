# encoding: UTF-8


# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@product1 = Product.create!(description: 'pot de 1kg', price: 13.5, year: Time.new.year, season: 'printemps', status: 'active')
@product2 = Product.create!(description: 'pot de 500g', price: 7, year: Time.new.year, season: 'printemps', status: 'active')
@product3 = Product.create!(description: 'pot de 1kg', price: 14.0, year: Time.new.year, season: 'été', status: 'active')
@product4 = Product.create!(description: 'pot de 500g', price: 7, year: Time.new.year, season: 'été', status: 'active') 

@admin_user = User.create!(first_name: "Antoine",
                                last_name: "Dumortier",
                                phone_number: "0302932084",
                                email: "antoine@example.com",
                                address: "61 rue de Philadelphie, 02300 Villequier-Aumont",
                                password: "pass",
                                role: 1
                              )

@user1 = User.create!( first_name: "Alex",
                                last_name: "Dumo",
                                phone_number: "0302932084",
                                email: "alex@example.com",
                                address: "71 Elm Street, 02139 Cambridge",
                                password: "pass",
                                role: 0
                              )

@booking1 = @user1.bookings.create!
@booking1.booking_products.create!(product: @product1, quantity: 2)
@booking1.booking_products.create!(product: @product2, quantity: 3)

@user2 = User.create!(first_name: "Steve",
                                last_name: "Boles",
                                phone_number: "0679157920",
                                email: "steve@example.com",
                                address: "54 Park Street, 43929 San Francisco",
                                password: "pass",
                                role: 0
                              )

@booking3 = @user2.bookings.create!
@booking3.booking_products.create!(product: @product1, quantity: 1)
@booking3.booking_products.create!(product: @product2, quantity: 9)


@user3 = User.create!(first_name: "Millie",
                                last_name: "Johns",
                                phone_number: "0678158926",
                                email: "millie@example.com",
                                address: "12 Market Street, 23010 Denver",
                                password: "pass",
                                role: 0
                              )

@booking5 = @user3.bookings.create!
@booking5.booking_products.create!(product: @product1, quantity: 6)
@booking5.booking_products.create!(product: @product2, quantity: 6)

@user4 = User.create!(first_name: "Elisabeth",
                                last_name: "Dumortier",
                                phone_number: "0323380681",
                                email: "elisabeth@example.com",
                                address: "4 rue du Touquet, 02300 Villequier-Aumont",
                                password: "pass",
                                role: 0
                              )
@booking6 = @user4.bookings.create!
@booking6.booking_products.create!(product: @product1, quantity: 1)
@booking6.booking_products.create!(product: @product2, quantity: 1)

