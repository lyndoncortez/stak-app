require 'rails_helper'

RSpec.describe 'Log in user', type: :system do
  describe 'log in as admin' do
    let(:user) { create :user }

    before do
      user.confirm
    end

    it 'signs the admin in' do
      visit new_admin_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
      expect(page).to have_current_path(root_path)
    end
  end

  describe 'log in as broker' do
    let(:broker) { create :broker }

    before do
      broker.confirm
    end

    it 'signs the broker in' do
      visit new_broker_session_path
      fill_in 'Email', with: broker.email
      fill_in 'Password', with: broker.password
      click_button 'Log in'
      expect(page).to have_current_path(home_broker_portfolio_path)
    end
  end
end
