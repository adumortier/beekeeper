# encoding: UTF-8
require 'rails_helper'

RSpec.describe "As a visitor " , type: :feature do 

  before(:each) do
    @default_user = User.create!(first_name: "Alex",
                                last_name: "Dumo",
                                phone_number: "0302932084",
                                email: "roman@example.com",
                                password: "hamburger01",
                              )
  end

  describe "When I visit the profile page " do 

    it "I can edit my profile" do 

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@default_user)

      visit('/')

      click_on 'Alex'

      click_on 'Modifier'
      
      fill_in :'user[first_name]', with: 'Alexis'
      fill_in :'user[last_name]', with: 'Dumortier'
      fill_in :'user[email]', with: 'alexis.dumortier@free.fr'
      fill_in :'user[phone_number]', with: '0667398732'

      click_on 'Enregistrer'
      
      expect(current_path).to eq('/profile')
      
      expect(page).to have_content('Prénom: Alexis')
      expect(page).to have_content('Nom: Dumortier')
      expect(page).to have_content('Email: alexis.dumortier@free.fr')
      expect(page).to have_content('Numéro de téléphone: 0667398732')

      expect(page).to_not have_content('Prénom: Alex')
      expect(page).to_not have_content('Nom: Dumo')
      expect(page).to_not have_content('Email: roman@example.com')
      expect(page).to_not have_content('Numéro de téléphone: 0302932084')
    end

  end

end