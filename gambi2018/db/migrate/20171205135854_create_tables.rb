class CreateTables < ActiveRecord::Migration[5.1]
  def change
    create_table :tables do |t|
      t.string :status
      t.string :group_name
      t.bigint :owner_id
      t.integer :max_people

      t.timestamps
    end
  end
end
