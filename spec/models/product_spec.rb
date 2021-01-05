require 'rails_helper'

RSpec.describe Product, type: :model do 

  describe 'validations' do 
    it { should validate_presence_of :description}
    
    it { should validate_presence_of :season}
    it do
      is_expected.to validate_numericality_of(:price),
      greater_than_or_equal_to: 0
    end

    it do
      is_expected.to validate_numericality_of(:year),
      only_integer: true, greater_than_or_equal_to: Date.current.year
    end
  end 


  describe 'relationships' do 
    it { should have_many :booking_products}
    it { should have_many(:bookings).through(:booking_products)}
  end 

end