class Admin::TablesController < ApplicationController

	before_action :verify_admin	
	before_action :validate_table_and_user, only: [:reserve, :add_member]

	def index
	end

	def confirm
		table = Table.find params[:table_id]
		table.update status: Table::CONFIRMED
		redirect_to admin_table_path(table)
	end

	def unconfirm
		table = Table.find params[:table_id]
		table.update status: Table::RESERVED
		redirect_to admin_table_path(table)
	end

	def cancel
		table = Table.find params[:table_id]
		table.update status: Table::FREE, group_name: nil, max_people: nil, owner_id: nil
		table.users.each do |user|
			user.update name: nil, phone: nil, table: nil
		end
		redirect_to admin_table_path(table)
	end

	def show
		@table = Table.find params[:id]
	end

	def add_member

		if @table.free? or @table.full? or @user.table
			abort_mission
			return
		end

		Table.transaction do
			@user.table = @table
			@user.name = params[:name]
			@user.phone = params[:phone]
			@user.save!
		end

		redirect_to admin_table_path(@table)
	end

	def reserve

		if not @table.free? or @user.table
			abort_mission
			return
		end

		Table.transaction do
			@user.name = params[:owner_name]
			@user.phone = params[:owner_phone]
			@user.table = @table
			@user.save!
			@table.owner_id = @user.id
			@table.group_name = params[:group_name]
			@table.max_people = params[:max_people]
			@table.status = Table::RESERVED
			@table.save!
		end

		redirect_to admin_table_path(@table)
	end

	private

	def validate_table_and_user

		@table = Table.find_by id: params[:table_id]
		@user = User.find_by username: params[:lote], password: params[:factura]

		if @table.nil? or @user.nil?
			abort_mission
			return 
		end
	end

	def abort_mission
		@error_message = "No es posible realizar la reserva de la mesa. Puede que la entrada ingresada ya este registrada en otra mesa o que la mesa no este disponible."

		puts "aborting!"

		redirect_to "/" and return if @table.nil?
		render "show" and return
	end

end
