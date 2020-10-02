# encoding: UTF-8

require 'rails_helper'

RSpec.describe "As a visitor " , type: :feature do 

  describe "When I visit my bookings" do 

    before(:each) do 
      @default_user = User.create!(first_name: "Alex",
                                last_name: "Dumo",
                                phone_number: "0302932084",
                                email: "roman@example.com",
                                password: "hamburger01",
                              )
      @product1 = Product.create!(description: 'pot de 1kg', price: 13.5, year: Time.new.year, season: 'printemps')
      @product2 = Product.create!(description: 'pot de 750g', price: 7, year: Time.new.year, season: 'printemps')                          
    
      @booking1 = @default_user.bookings.create!
      @booking1.booking_products.create!(product: @product1, quantity: 7)

      @booking2 = @default_user.bookings.create!
      @booking2.booking_products.create!(product: @product2, quantity: 2)
    end

    it 'I can delete bookings' do 
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@default_user)
      visit('/reservation')
      within "#booking-#{@booking1.id}" do
        expect(page).to have_content(@booking1.booking_products[0].quantity.to_s + ' ' + @booking1.booking_products[0].product.description)
      end
      
      within "#booking-#{@booking2.id}" do
        expect(page).to have_content(@booking2.booking_products[0].quantity.to_s + ' ' + @booking2.booking_products[0].product.description)
        click_on "Annuler"
      end
      
      expect(page).to have_content('Votre réservation a été annulée')

      expect(page).to_not have_css("#booking-#{@booking2.id}")
      expect(page).to have_css("#booking-#{@booking1.id}")
    end

  end

end