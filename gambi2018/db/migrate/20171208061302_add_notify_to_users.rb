class AddNotifyToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :notify, :boolean, default: false
  end
end
