require 'rails_helper'

RSpec.describe 'View User', type: :system do
  describe 'clicking the card' do
    let(:user) { create :user }

    before do
      user.confirm
    end

    it 'views a user' do
      visit new_admin_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
      find('#usersId').click
      sleep(3)
      find('#viewUserId').click
      sleep(3)
      expect(page).to have_current_path(admins_show_user_path(user.id))
    end
  end
end
