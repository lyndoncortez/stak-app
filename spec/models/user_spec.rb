require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation test' do
    it 'is invalid without a name' do
      user = described_class.new(email: 'sample@email.com', password: '123456').save
      expect(user).to eq(false)
    end
  end
end
