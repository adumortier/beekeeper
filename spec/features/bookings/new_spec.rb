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
      @product2 = Product.create!(description: 'pot de 750g', price: 7.0, year: Time.new.year, season: 'été')
    end

    it 'I can make reservations' do 

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@default_user)
      visit('/')
      click_on('Mes Réservations')
      expect(page).to have_content("Vous n'avez pas encore de réservations")
      click_on('Réservez des pots !')

      expect(current_path).to eq('/reservation/new')

      fill_in "booking[quantity_#{@product1}]", with: 3
      fill_in "booking[quantity_#{@product2}]", with: 3
      # fill_in 'booking[count_750g]', with: 2
      # select "printemps", :from => "booking[season]"
      # select Date.today.year.to_s, :from => "booking[year]"

      click_on('Envoyer')

      expect(current_path).to eq('/reservation')

      @booking = @default_user.bookings.last
    
      within "#booking-#{@booking.id}" do
        
        expect(page).to have_content(@booking.count_750g.to_s + ' pots de 750g')
        expect(page).to have_content(@booking.count_1kg.to_s + ' pots de 1kg')
        expect(page).to have_content(@booking.season)
        expect(page).to have_content(@booking.year)
        expect(page).to have_content(@booking.created_at.strftime("%d/%m/%Y"))
      end

    end

  end

end