class Stock < ApplicationRecord
  has_many :user_stocks, dependent: :nil
  has_many :users, through: :user_stocks
end
