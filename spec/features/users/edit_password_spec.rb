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

    it "I can edit my password" do 

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@default_user)

      visit('/')

      click_on 'Alex'

      click_on 'Changer de mot de passe'
      
      fill_in :'user[password]', with: 'hamburger02'
      fill_in :'user[password_confirmation]', with: 'hamburger02'

      click_on 'Enregistrer'

      expect(current_path).to eq('/profile')
      expect(page).to have_content('Votre mot de passe a été mis à jour')

    end

    it "I can not edit my password if the confirmation is different" do 

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@default_user)

      visit('/')

      click_on 'Alex'

      click_on 'Changer de mot de passe'
      
      fill_in :'user[password]', with: 'hamburger03'
      fill_in :'user[password_confirmation]', with: 'hamburger04'

      click_on 'Enregistrer'

      expect(current_path).to eq('/user/password/edit')
      expect(page).to have_content('Le mot de passe et la confirmation sont différents')

    end

  end

end