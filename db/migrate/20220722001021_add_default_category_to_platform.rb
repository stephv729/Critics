class AddDefaultCategoryToPlatform < ActiveRecord::Migration[7.0]
  def change
    change_column_default(:platforms, :category, from:nil , to: 0)
  end
end
