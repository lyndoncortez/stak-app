class AdminsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin?

end
