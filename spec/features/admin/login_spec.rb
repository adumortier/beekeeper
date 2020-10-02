# encoding: UTF-8
require 'rails_helper'

RSpec.describe "As a visitor " , type: :feature do 

  before(:each) do
    @admin_user = User.create!(first_name: "Antoine",
                                last_name: "Dumortier",
                                phone_number: "0302932084",
                                email: "antoine@example.com",
                                password: "hamburger01",
                                role: 1
                              )
  end

  describe "When I visit the homepage " do 

    it "I can login" do 
      
      visit('/')
      click_on "Connexion"
      
      expect(current_path).to eq('/login')

      fill_in :email, with: 'antoine@example.com'
      fill_in :password, with: 'hamburger01'

      click_on "Se connecter"

      expect(page).to_not have_link('Mes Réservations')

      expect(current_path).to eq('/admin')

      expect(page).to have_content('Antoine')
      expect(page).to have_content("Les Filles d'Antoine")
      click_on "Les Filles d'Antoine"
      expect(current_path).to eq('/')

      expect(page).to have_content("Tableau de bord")
      click_on "Tableau de bord"
      expect(page).to have_link('Réservations')
      expect(page).to have_link("Produits")
      expect(page).to have_link("Commentaires")
      expect(page).to have_link("Gestion emails")
      
      expect(page).to have_content('Déconnexion')
      expect(page).to_not have_content('Connexion')
    end

  end

end