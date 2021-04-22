class UserStock < ApplicationRecord
  has_many :buyer_stocks, dependent: :destroy
  has_many :buyers, through: :buyer_stocks, foreign_key: :user_id, source: :user
end
