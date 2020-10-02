require 'rails_helper'

RSpec.describe "As a visitor " , type: :feature do 

  describe "When I visit the root page" do 

    it "shows information about the webpage" do 
      visit('/')
      expect(page).to have_content("Les Filles d'Antoine")
    end

  end

end