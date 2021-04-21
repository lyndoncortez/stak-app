require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) do
    described_class.new(name: 'User Example',
                                   email: 'user@example.com',
                                   password: '123456',
                                   type: 'Admin')
  end

  it 'is valid with valid attributes' do
    expect(user).to be_valid
  end

  it 'is not valid without a name' do
    user.name = nil
    expect(user).not_to be_valid
  end

  it 'is not valid when name is too long' do
    user.name = 'a' * 21
    expect(user).not_to be_valid
  end

  it 'is not valid when email format is incorrect' do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
    addresses.each do |invalid_address|
      user.email = invalid_address
    end
    expect(user).not_to be_valid
  end

  describe 'when email address is already taken' do
    before do
      user_with_same_email = user.dup
      user_with_same_email.save
    end

    it 'is not valid' do
      expect(user).not_to be_valid
    end
  end
end
