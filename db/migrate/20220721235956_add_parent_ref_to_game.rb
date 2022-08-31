class AddParentRefToGame < ActiveRecord::Migration[7.0]
  def change
    add_reference :games, :parent, foreign_key: { to_table: :games }
  end
end
