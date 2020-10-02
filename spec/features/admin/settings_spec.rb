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
    @product1 = Product.create!(description: 'pot de 1kg', price: 13.5, year: Time.new.year, season: 'printemps')
    @product2 = Product.create!(description: 'pot de 750g', price: 7.0, year: Time.new.year, season: 'été')
  end

  describe " when I visit the dashboard," do 

    it "I can view the price of each type of my products" do 
      
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_user)
      
      visit('/admin/products')
      
      within("#product-#{@product1.id}") do
        expect(page).to have_content("#{@product1.description} #{@product1.price} #{@product1.season} #{@product1.year}")
      end
   
      within("#product-#{@product2.id}") do
        expect(page).to have_content("#{@product2.description} #{@product2.price} #{@product2.season} #{@product2.year}")
      end

    end

    it "I can edit the price of each type of my products" do 
      
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_user)
      
      visit('/admin/products')

      within("#product-#{@product1.id}") do
        click_on 'Modifier'
      end

      expect(current_path).to eq("/admin/products/#{@product1.id}/edit")

      fill_in 'product[description]', with: 'pot de 2kg'
      fill_in 'product[price]', with: 20.0
      click_on 'Continuer'

      expect(current_path).to eq("/admin/products")

      within("#product-#{@product1.id}") do
        expect(page).to have_content("pot de 2kg 20.0 printemps 2020")
      end

    end

    it "I can add a new product" do 
      
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_user)
      
      visit('/admin/products')

      expect(page).to have_content('pot de 1kg')
      expect(page).to have_content('pot de 750g')
      expect(page).to_not have_content('pot de 3kg')

      click_on 'Ajouter un produit'

      expect(current_path).to eq("/admin/products/new")

      fill_in 'product[description]', with: 'pot de 3kg'
      fill_in 'product[price]', with: 40.0
      fill_in 'product[year]', with: Time.new.year
      fill_in 'product[season]', with: 'printemps'
      click_on 'Continuer'

      expect(current_path).to eq("/admin/products")

      expect(page).to have_content('pot de 3kg')

    end


    it "I can delete a product" do 
      
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_user)
      
      visit('/admin/products')
      
      expect(page).to have_content('pot de 1kg')

      within("#product-#{@product1.id}") do
        click_on "Effacer"
      end

      expect(current_path).to eq("/admin/products")

      expect(page).to_not have_content('pot de 1kg')
    end
    
  end
end