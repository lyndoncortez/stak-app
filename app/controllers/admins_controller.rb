class AdminsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin?

  def index
    @users = User.all
  end

  def new_user
    @user = User.new
  end

  def create_user
    @user = User.new(user_params)
    if @user.save
      redirect_to admins_index_path
      flash[:success] = 'User profile successfully created.'
    else
      flash.now[:danger] = @user.errors.full_messages[0]
      render :new_user
    end
  end

  def show_user
    @user = User.find(params[:id])
  end

  def edit_user
    @user = User.find(params[:id])
  end

  def update_user
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admins_index_path
      flash[:success] = "#{@user.name} profile successfully updated."
    else
      flash.now[:danger] = @user.errors.full_messages[0]
      render :edit_user
    end
  end

  def pending
    @users = User.where(approved: false)
  end

  def approve_user
    user = User.find(params[:id])
    user.approved = true
    @email = user.email
    if user.save
      flash[:success] = "#{user.name} approved."
      AdminMailer.account_approved(@email).deliver_now
    else
      flash[:danger] = 'User approval failed.'
    end
    redirect_to admins_pending_path
  end

  def cancel_user
    User.find(params[:id]).destroy
    redirect_to admins_index_path
    flash[:warning] = 'User successfully cancelled.'
  end

  private

  def admin?
    redirect_to root_path unless current_user.type == 'Admin'
  end

  def user_params
    params.require(:user).permit(:name, :email, :type, :password, :password_confirmation)
  end
end
