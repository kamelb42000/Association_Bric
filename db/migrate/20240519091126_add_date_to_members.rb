class AddDateToMembers < ActiveRecord::Migration[7.0]
  def change
    add_column :members, :date, :datetime
  end
end
