require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation test' do
    it 'is invalid without a name' do
      user = User.new(email:'sample@email.com', password: '123456' ).save
      expect(user).to eq(false)
    end
  end
end
