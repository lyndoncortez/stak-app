require 'rails_helper'

RSpec.describe 'Search Stocks', type: :system do
    let(:broker) { create :broker }

    before do
      broker.confirm
    end

    it 'searches a stock' do
      visit new_broker_session_path
      fill_in 'Email', with: broker.email
      fill_in 'Password', with: broker.password
      click_button 'Log in'
      fill_in 'symbol', with: 'AAPL'
      find('#searchId').click
      sleep(3)
      expect(page).to have_content("Apple")
    end
end
