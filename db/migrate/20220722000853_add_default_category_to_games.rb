class AddDefaultCategoryToGames < ActiveRecord::Migration[7.0]
  def change
    change_column_default(:games, :category, from:nil , to: 0)
  end
end
