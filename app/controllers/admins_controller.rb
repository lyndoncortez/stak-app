class AdminsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin?

  def dashboard; end

  def index; end
end
