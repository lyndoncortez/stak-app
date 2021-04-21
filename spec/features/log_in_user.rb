require 'rails_helper'

RSpec.describe 'Log in user', type: :system do
  describe 'log in as admin' do
    let(:user) { create :user }

    it 'signs the admin in' do
      visit new_admin_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
    end

    expect(page).to have_current_path(root_path)
  end
end
