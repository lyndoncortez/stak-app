class Broker < User
  has_many :broker_stocks, class_name: 'UserStock', dependent: :destroy, inverse_of: :broker, foreign_key: :user_id
  has_many :stocks, through: :broker_stocks

  after_create :send_admin_mail, :send_user_mail

  def send_admin_mail
    AdminMailer.new_user_waiting_for_approval(self).deliver
  end

  def send_user_mail
    AdminMailer.account_approved(self).deliver
  end
end
