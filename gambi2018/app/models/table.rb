class Table < ApplicationRecord

	FREE = "Disponible"
	RESERVED = "Reservada"
	CONFIRMED = "Confirmada"

	has_many :users

	def owner
		User.find_by id: owner_id
	end

	def free?
		self.status == FREE
	end

	def full?
		self.users.count >= self.max_people
	end

	def confirmed?
		self.status == CONFIRMED
	end

	def reserved?
		self.status == RESERVED
	end

	def has_room?
		not free? and users.count < max_people
	end

end
