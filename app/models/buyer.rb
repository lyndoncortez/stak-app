class Buyer < User
  has_many :buyer_stocks, dependent: :destroy, foreign_key: :user_id
  has_many :user_stocks, through: :buyer_stocks
  has_many :transactions, dependent: :destroy, foreign_key: :user_id

  before_create :approve_buyer, :confirm_buyer
  after_create :send_registration_mail

  def approve_buyer
    self.approved = true
  end

  def confirm_buyer
    skip_confirmation!
  end

  def send_registration_mail
    AdminMailer.registration_successful(self).deliver
  end
end
