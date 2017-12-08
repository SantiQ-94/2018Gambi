class WebController < ApplicationController

	def index
		@table = @current_user.table if @current_user
	end

	def login
		reset_session if @current_user
		user = User.find_by username: params[:username], password: ""#params[:password]
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

	def join
		redirect_to "/" and return if @current_user.nil?
		@table = Table.find_by id: params[:table_id]

		if @table.nil? or @table.free? or @table.full? or @current_user.table
			render "index"
			return
		end

		Table.transaction do
			@current_user.table = @table
			@current_user.name = params[:name]
			@current_user.phone = params[:phone]
			@current_user.save!
		end

		redirect_to root_path

	end

	def reserve
		redirect_to "/" and return if @current_user.nil?
		@table = Table.find_by id: params[:table_id]

		if @table.nil? or not @table.free? or @current_user.table
			render "index"
			return
		end

		Table.transaction do
			@current_user.name = params[:owner_name]
			@current_user.phone = params[:owner_phone]
			@current_user.table = @table
			@current_user.save!
			@table.owner_id = @current_user.id
			@table.group_name = params[:group_name]
			@table.max_people = params[:max_people]
			@table.status = Table::RESERVED
			@table.save!
		end

		redirect_to root_path
	end

end
