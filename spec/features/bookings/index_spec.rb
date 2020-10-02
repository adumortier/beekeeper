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
    end

    it 'I see a list of all my bookings' do 
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@default_user)
      visit('/reservation')
      expect(page).to have_content("Vous n'avez pas encore de réservations")
    end

  end

end