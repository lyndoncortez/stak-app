require 'rails_helper'

RSpec.describe 'Edit User', type: :system do
  describe 'clicking the edit user button' do
    let(:user) { create :user }

    before do
      user.confirm
    end

    it 'edits a user' do
      visit new_admin_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
      find('#usersId').click
      find('#editUserId').click
      fill_in 'Name', with: 'Lyndon'
      click_button 'Edit'
      expect(page).to have_current_path(admins_index_path)
    end
  end
end
