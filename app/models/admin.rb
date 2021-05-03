class Admin < User
  before_create :approve_admin, :confirm_admin

  USER_TYPE_OPTIONS = ['Admin', 'Buyer', 'Broker']

  def approve_admin
    self.approved = true
  end

  def confirm_admin
    skip_confirmation!
  end
end
