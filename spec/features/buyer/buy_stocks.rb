require 'rails_helper'

RSpec.describe 'Buy Stocks', type: :system do
    let(:buyer) { create :buyer }

    before do
      buyer.confirm
    end

    it 'buys a stock' do
      visit new_buyer_session_path
      fill_in 'Email', with: buyer.email
      fill_in 'Password', with: buyer.password
      click_button 'Log in'
      fill_in 'symbol', with: 'AAPL'
      find('#searchId').click
      find('#buy-broker-btn').click
      click_button 'Buy'
      fill_in 'quantity', with: '1'
      click_button 'Buy'
      expect(page).to have_current_path(home_transactions_path)
    end
end
