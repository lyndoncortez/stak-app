class Stock < ApplicationRecord
  validates :symbol, presence: true
  validates :name, presence: true

  has_many :user_stocks, dependent: :destroy
  has_many :users, through: :user_stocks
end
