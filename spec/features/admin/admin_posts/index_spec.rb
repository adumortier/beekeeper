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

    @post1 = @admin_user.posts.create!(title: "what a nice day to go beekeeping!", content: "I went beekeeping today. It was fun")
    @post2 = @admin_user.posts.create!(title: "Another rainy day in Picardy", content: "I think I'll stay home and warm!")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_user)
  end

  describe " when I visit the dashboard," do 

    it "I can view all my posts" do 

      visit '/admin'
      click_on 'Posts'

      expect(current_path).to eq('/admin/posts')

      within("#post-#{@post1.id}") do
        expect(page).to have_content(@post1.title)
        expect(page).to have_content(@post1.content)
      end

      within("#post-#{@post2.id}") do
        expect(page).to have_content(@post2.title)
        expect(page).to have_content(@post2.content)
      end
      
    end

  it "I can add a new post" do 

      visit '/admin'
      click_on 'Posts'

      expect(current_path).to eq('/admin/posts')

      click_on "Ajouter un post"
      expect(current_path).to eq('/admin/posts/new')

      fill_in 'post[title]', with: 'this is a new post'
      fill_in 'post[content]', with: 'this is the content of the post'
      click_on "Continuer"

      expect(current_path).to eq('/admin/posts')

      expect(page).to have_content('this is a new post')
      expect(page).to have_content('this is the content of the post')

    end
  end

end
