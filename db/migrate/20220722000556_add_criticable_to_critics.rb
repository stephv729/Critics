class AddCriticableToCritics < ActiveRecord::Migration[7.0]
  def change
    add_reference :critics, :criticable, polymorphic: true, null: false
  end
end
