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

end
