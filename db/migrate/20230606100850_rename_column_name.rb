class RenameColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :cars, :type, :car_type
    rename_column :cars, :model, :car_model
    rename_column :cars, :color, :car_color
  end
end
