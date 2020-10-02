# encoding: UTF-8
require 'rails_helper'

RSpec.describe "As an admin user," , type: :feature do 

  before(:each) do
    @admin_user = User.create!(first_name: "Antoine",
                                last_name: "Dumortier",
                                phone_number: "0302932084",
                                email: "antoine@example.com",
                                password: "hamburger01",
                                role: 1
                              )
    @user1 = User.create!( first_name: "Alex",
                                last_name: "Dumo",
                                phone_number: "0302932084",
                                email: "alex@example.com",
                                password: "2345",
                                role: 0
                              )

    @product1 = Product.create!(description: 'pot de 1kg', price: 13.5, year: Time.new.year, season: 'printemps')
    @product2 = Product.create!(description: 'pot de 750g', price: 7, year: Time.new.year, season: 'printemps')                          
    @product3 = Product.create!(description: 'pot de 1kg', price: 14.0, year: Time.new.year, season: 'été')
    @product4 = Product.create!(description: 'pot de 750g', price: 7, year: Time.new.year, season: 'été') 

    @booking1 = @user1.bookings.create!
    @booking1.booking_products.create!(product: @product1, quantity: 2)

    @booking2 = @user1.bookings.create!
    @booking2.booking_products.create!(product: @product3, quantity: 2)

    @user2 = User.create!(first_name: "Steve",
                                last_name: "Boles",
                                phone_number: "0679157920",
                                email: "steve@example.com",
                                password: "1234",
                                role: 0
                              )
    @booking3 = @user2.bookings.create!
    @booking3.booking_products.create!(product: @product2, quantity: 2)

    @booking4 = @user2.bookings.create!
    @booking4.booking_products.create!(product: @product4, quantity: 7)

  end

  describe " when I visit the dashboard," do 

    it "I can view all my bookings for the year" do 
      
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_user)
      
      visit('/admin/bookings')

      within("#printemps") do

        within("#booking-#{@booking1.id}") do
          expect(page).to have_content('Alex Dumo')
          expect(page).to have_content('alex@example.com')
          expect(page).to have_content("#{@booking1.created_at.strftime("%d/%m/%Y")}")
          expect(page).to have_content("#{@booking1.booking_products[0].quantity}")
        end

        within("#booking-#{@booking3.id}") do
          expect(page).to have_content('Steve Boles')
          expect(page).to have_content('steve@example.com')
          expect(page).to have_content("#{@booking3.created_at.strftime("%d/%m/%Y")}")
          expect(page).to have_content("#{@booking3.booking_products[0].quantity}")
        end

      end

      within("#ete") do

        within("#booking-#{@booking2.id}") do
          expect(page).to have_content('Alex Dumo')
          expect(page).to have_content('alex@example.com')
          expect(page).to have_content("#{@booking2.created_at.strftime("%d/%m/%Y")}")
          expect(page).to have_content("#{@booking2.booking_products[0].quantity}")
        end
        within("#booking-#{@booking4.id}") do
          expect(page).to have_content('Steve Boles')
          expect(page).to have_content('steve@example.com')
          expect(page).to have_content("#{@booking4.created_at.strftime("%d/%m/%Y")}")
          expect(page).to have_content("#{@booking4.booking_products[0].quantity}")
        end
        
      end
      
    end
  end
end