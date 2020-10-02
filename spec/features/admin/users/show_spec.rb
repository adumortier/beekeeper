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

    @booking1 = @user1.bookings.create!
    @booking1.booking_products.create!(product: @product1, quantity: 2)
  end

  describe "when click a users name" do

    it 'I can see the user info' do
  
      visit('/admin/bookings')

      within("#printemps") do
        within("#booking-#{@booking1.id}") do
          click_on('Alex Dumo')
        end
        expect(current_path).to eq("/admin/users/#{@user1.id}") 
      end
      expect(page).to have_content("#{@user1.first_name} #{@user1.last_name}")
      expect(page).to have_content(@user1.phone_number)
      expect(page).to have_content(@user1.email)
    end

  end
  
end