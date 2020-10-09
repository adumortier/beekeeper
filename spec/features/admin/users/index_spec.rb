# encoding: UTF-8
require 'rails_helper'

RSpec.describe "As an admin user," , type: :feature do 

  before(:each) do
    @admin_user = User.create!(first_name: "Antoine",
                                last_name: "Dumortier",
                                phone_number: "0302932084",
                                email: "antoine@example.com",
                                password: "pass",
                                role: 1
                          )
    
    @user1 = User.create!( first_name: "Alex",
                          last_name: "Dumo",
                          phone_number: "0302932084",
                          email: "alex@example.com",
                          password: "pass",
                          role: 0,
                          created_at: 3.weeks.ago
                          )

    @user2 = User.create!( first_name: "Jojo",
                          last_name: "Dumo",
                          phone_number: "0302232084",
                          email: "jojo@example.com",
                          password: "pass",
                          role: 0,
                          created_at: 2.weeks.ago
                          )

    @user3 = User.create!( first_name: "Nico",
                          last_name: "Dumo",
                          phone_number: "0202239084",
                          email: "nico@example.com",
                          password: "pass",
                          role: 0,
                          created_at: 1.month.ago
                          )
  end

  describe "when I visit the users pages" do

    it 'I can see a list of all my users' do
      visit('/admin/users')
      within("#user-#{@user1.id}") do
        expect(page).to have_content(@user1.first_name + ' ' + @user1.last_name)
        expect(page).to have_content(@user1.phone_number)
        expect(page).to have_content(@user1.email)
        expect(page).to have_content(@user1.created_at.strftime("%d/%m/%Y"))
      end
      within("#user-#{@user2.id}") do

        expect(page).to have_content(@user2.first_name + ' ' + @user2.last_name)
        expect(page).to have_content(@user2.last_name)
        expect(page).to have_content(@user2.phone_number)
        expect(page).to have_content(@user2.created_at.strftime("%d/%m/%Y"))
      end
    end

    it 'I can see delete a user' do
      visit('/admin/users')
      within("#user-#{@user1.id}") do
        expect(page).to have_content(@user1.first_name + ' ' + @user1.last_name)
        expect(page).to have_content(@user1.phone_number)
        expect(page).to have_content(@user1.email)
        expect(page).to have_content(@user1.created_at.strftime("%d/%m/%Y"))
      end
      within("#user-#{@user2.id}") do
        expect(page).to have_content(@user2.first_name + ' ' + @user2.last_name)
        expect(page).to have_content(@user2.last_name)
        expect(page).to have_content(@user2.phone_number)
        expect(page).to have_content(@user2.created_at.strftime("%d/%m/%Y"))
      end
      
      within("#user-#{@user3.id}") do
        click_on 'Effacer'
      end

      expect(current_path).to eq('/admin/users')
      expect(page).to_not have_css("#user-#{@user3.id}")
      expect(page).to have_css("#user-#{@user2.id}")
    end

    it 'I can add a new user' do
      visit('/admin/users')
      
      click_on 'Ajouter un client'
      
      expect(current_path).to eq('/admin/users/new')
      
      fill_in 'user[first_name]', with: 'George'
      fill_in 'user[last_name]', with: 'Durand'
      fill_in 'user[email]', with: 'george@example.com'
      fill_in 'user[password]', with: 'pass'
      fill_in 'user[password_confirmation]', with: 'pass'
    end
  end


  
end