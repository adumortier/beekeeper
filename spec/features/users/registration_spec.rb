# encoding: UTF-8
require 'rails_helper'

RSpec.describe "As a visitor " , type: :feature do 

  describe "When I visit the homepage " do 

    it "I can create a new user" do 
      
      visit '/'
      click_on "Créer un compte"
      
      expect(current_path).to eq('/register')

      fill_in :user_first_name, with: 'Alexis'
      fill_in :user_last_name, with: 'Dumortier'
      fill_in :user_email, with: 'alexis.dumortier@free.fr'
      fill_in :user_phone_number, with: '0667398732'
      fill_in :user_password, with: '123456'
      fill_in :user_password_confirmation, with: '123456'

      click_on "Continuer"

      expect(current_path).to eq("/")

      expect(page).to have_content("Bienvenue Alexis!")
      expect(page).to have_content("Réservez vos pots!")
      click_on "Alexis"
      expect(page).to have_content("Prénom: Alexis")
      expect(page).to have_content("Nom: Dumortier")
      expect(page).to have_content("Email: alexis.dumortier@free.fr")
      expect(page).to have_content("Numéro de téléphone: 0667398732")
    end

  end

end