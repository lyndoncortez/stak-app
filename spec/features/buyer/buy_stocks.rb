require 'rails_helper'

RSpec.describe 'Buy Stocks', type: :system do
  let(:buyer) { create :buyer }
  let(:broker) { create :broker }

  before do
    buyer.confirm
    broker.confirm
  end

  it 'broker adds a stock' do
    visit new_broker_session_path
    fill_in 'Email', with: broker.email
    fill_in 'Password', with: broker.password
    click_button 'Log in'
    fill_in 'symbol', with: 'AAPL'
    find('#searchId').click
    sleep(3)
    find('#addStockId').click
    expect(page).to have_content('Stock Added')
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
    sleep(3)
    fill_in 'quantity', with: '1'
    click_button 'Buy'
    expect(page).to have_current_path(home_transactions_path)
  end
end
