class AdminsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin?

  def dashboard; end

  def index; end

  def new_user
    @user = User.new
  end

  def pending
    @users = User.where(approved: false)
  end

  private

  def admin?
    redirect_to root_path unless current_user.type == 'Admin'
  end
end
