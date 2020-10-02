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

    it "I can login" do 
      
      visit('/')
      click_on "Connexion"
      
      expect(current_path).to eq('/login')

      fill_in :email, with: 'roman@example.com'
      fill_in :password, with: 'hamburger01'

      click_on "Se connecter"

      expect(current_path).to eq("/")

      expect(page).to have_content("Alexis")
      expect(page).to have_content("Déconnexion")
      expect(page).to_not have_content("Connexion")
    end

  end

end