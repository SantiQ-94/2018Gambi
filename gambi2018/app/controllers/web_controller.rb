class WebController < ApplicationController

	def index
		
	end

	def login
		reset_session if @current_user
		user = User.find_by username: params[:username], password: params[:password]
		session[:user_id] = user.id if not user.nil?
		@authentication_error = true if user.nil?
		load_user
		redirect_to "/" and return if @current_user
		render "index"
	end

	def logout
		reset_session
		redirect_to "/"
	end
end
