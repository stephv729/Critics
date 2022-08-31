class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :role, null: false, default: "regular"
      t.integer :critics_count, default: 0

      t.timestamps
    end
  end
end
