class AddColumnsToService < ActiveRecord::Migration[7.0]
  def change
    add_column :services, :first_name, :string
    add_column :services, :last_name, :string
    add_column :services, :address, :string
  end
end
