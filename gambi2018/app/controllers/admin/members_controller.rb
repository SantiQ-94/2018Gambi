class Admin::MembersController < ApplicationController

	before_action :verify_admin

	def index
		
	end

	def toggle
		user = User.find params[:member_id]
		user.update notify: (not user.notify)
	end

	def update
		user = User.find params[:id]
		user.update(name: params[:name], phone: params[:phone])
		redirect_to admin_table_path(user.table)
	end

	def destroy
		user = User.find params[:id]
		table = user.table
		user.table_id = nil
		user.save
		redirect_to admin_table_path(table)
	end

end
