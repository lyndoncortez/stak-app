require 'rails_helper'

RSpec.describe 'Add User', type: :system do
  describe 'clicking the add user button' do
    let(:user) { create :user }

    before do
      user.confirm
    end

    it 'adds a user' do
      visit new_admin_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
      find('#addUserId').click
      fill_in 'Name', with: 'Goku'
      fill_in 'Email', with: 'goku@dragonball.com'
      fill_in 'user_password', with: 'songoku'
      fill_in 'user_password_confirmation', with: 'songoku'
      select('Broker', from: 'user_type')
      click_button 'Create'
      

      
      expect(page).to have_current_path(admins_index_path)
    end
  end
end
