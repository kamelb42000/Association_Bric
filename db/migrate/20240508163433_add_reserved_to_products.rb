class AddReservedToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :reserved, :boolean, default: false
  end
end
