class AdminsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin?

  def dashboard; end

  def index
    @users = User.all
  end

  def new_user
    @user = User.new
  end

  def show_user
    @user = User.find(set_user)
  end

  def pending
    @users = User.where(approved: false)
  end

  def approve_user
    user = User.find(set_user)
    user.approved = true
    @email = user.email
    if user.save
      flash[:notice] = "#{user.name} approved"
      AdminMailer.account_approval(@email).deliver_now
    else
      flash[:alert] = "#{user.name} approval failure"
    end
    redirect_to admins_pending_approval_path
  end

  private

  def admin?
    redirect_to root_path unless current_user.type == 'Admin'
  end

  def set_user
    params[:id]
  end
end
