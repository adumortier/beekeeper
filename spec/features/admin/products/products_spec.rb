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

  end

  describe " when I visit the dashboard," do 

    it "I can view all my bookings for the year" do 
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_user)
      
    end
  end
end