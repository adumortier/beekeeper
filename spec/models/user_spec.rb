require 'rails_helper'

RSpec.describe User, type: :model do 

  describe 'validations' do 
    it { should validate_presence_of :first_name}
    it { should validate_presence_of :last_name}
    it { should validate_presence_of :email}
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :password }
  end 

  describe 'relationships' do 
    it { should have_many :bookings}
    it { should have_many :posts}
  end 

end