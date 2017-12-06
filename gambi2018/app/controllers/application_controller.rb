class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :load_user

  private

  def load_user
  	@current_user = User.find_by id: session[:user_id]
  end

  def verify_admin
    redirect_to "/" and return if @current_user.nil? or not @current_user.admin?
  end

end
