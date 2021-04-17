class AdminsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin?

  def dashboard 
    @pending = User.where(approved:false)
  end

  def index; end
end
