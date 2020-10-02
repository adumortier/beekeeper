require 'rails_helper'

RSpec.describe Booking, type: :model do 

  describe 'relationships' do 
    it { should belong_to :user}
    it { should have_many :booking_products}
    it { should have_many(:products).through(:booking_products)}
  end 

end