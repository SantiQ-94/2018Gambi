User.create! username: "admin", password: "admin"

(1..10).to_a.each do |id|
	User.create! username: id, password: id
end 

300.times do 
	Table.create! status: Table::FREE
end