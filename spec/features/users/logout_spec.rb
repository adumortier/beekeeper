# encoding: UTF-8
require 'rails_helper'

RSpec.describe "As a visitor " , type: :feature do 

  before(:each) do
    @default_user = User.create!(first_name: "Alexis",
                                last_name: "Dumortier",
                                phone_number: "0302932084",
                                email: "roman@example.com",
                                password: "hamburger01",
                              )
  end

  describe "When I visit the homepage " do 

    it "I can logout" do
      
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@default_user)

      visit('/')
      
      click_on "Déconnexion"
      
      expect(current_path).to eq('/')
      expect(page).to have_content("Vous avez été déconnecté(e)")
      expect(page).to have_content("Connexion")
      expect(page).to have_content("Home")
    end

  end

end