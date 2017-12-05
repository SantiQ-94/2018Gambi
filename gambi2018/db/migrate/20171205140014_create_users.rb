class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.references :table, foreign_key: true
      t.string :name
      t.bigint :phone

      t.timestamps
    end
  end
end
