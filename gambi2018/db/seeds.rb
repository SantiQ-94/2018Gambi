User.create! username: "admin", password: "admin"

(1..900).to_a.each do |id|
	User.create! username: format("%05d", id), password: ""
end 

300.times do
	Table.create! status: Table::FREE
end