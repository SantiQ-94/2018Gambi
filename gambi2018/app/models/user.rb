class User < ApplicationRecord
  belongs_to :table, optional: true

  def admin?
  	username == "admin"
  end

  def notify_status
  	return "processing" if table and notify
  	return "confirmed" if table and not notify
  	return "disabled"
  end

end
