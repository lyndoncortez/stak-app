class Admin < User
  before_create :approve_admin, :confirm_admin

  USER_TYPE_OPTIONS = %w[Admin Buyer Broker].freeze

  def approve_admin
    self.approved = true
  end

  def confirm_admin
    skip_confirmation!
  end
end
