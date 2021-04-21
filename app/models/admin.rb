class Admin < User
  after_create :send_admin_mail

  def send_admin_mail
    AdminMailer.new_user_waiting_for_approval(email).deliver
  end

  USER_TYPE_OPTIONS = %w[Admin Buyer Broker].freeze
end
