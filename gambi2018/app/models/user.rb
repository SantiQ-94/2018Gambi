class User < ApplicationRecord
  belongs_to :table, optional: true

  def admin?
  	username == "admin"
  end

end
