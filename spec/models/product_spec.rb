require 'rails_helper'

RSpec.describe Product, type: :model do 

  describe 'validations' do 
    it { should validate_presence_of :description}
    it { should validate_presence_of :price}
    it { should validate_presence_of :season}
    it { should validate_presence_of :year}
  end 

  describe 'relationships' do 
    it { should have_many :booking_products}
    it { should have_many(:bookings).through(:booking_products)}
  end 

end