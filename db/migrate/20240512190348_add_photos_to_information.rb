class AddPhotosToInformation < ActiveRecord::Migration[7.0]
  def change
    add_column :information, :photos, :jsonb
  end
end
