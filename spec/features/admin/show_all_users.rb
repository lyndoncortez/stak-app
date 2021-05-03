require 'rails_helper'

RSpec.describe 'Show all users', type: :system do
  describe 'clicking the card' do
    let(:user) { create :user }

    before do
      user.confirm
    end

    it 'shows all the users' do
      visit new_admin_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
      find('#usersId').click
      expect(page).to have_current_path(admins_index_path)
      expect(page).to have_content('List of Users')
    end
  end

  describe 'clicking the link' do
    let(:user) { create :user }

    before do
      user.confirm
    end

    it 'shows all the users' do
      visit new_admin_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
      click_link 'Users'
      click_link 'See all Users'
      expect(page).to have_current_path(admins_index_path)
      expect(page).to have_content('List of Users')
    end
  end
end
