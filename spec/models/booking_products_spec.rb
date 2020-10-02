require 'rails_helper'

RSpec.describe BookingProduct, type: :model do

  describe 'validations' do 
    it { should validate_presence_of :quantity}
  end

  describe "relationships" do
    it {should belong_to :booking}
    it {should belong_to :product}
  end
end