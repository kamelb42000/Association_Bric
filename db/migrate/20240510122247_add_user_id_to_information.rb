class AddUserIdToInformation < ActiveRecord::Migration[7.0]
  def change
    add_reference :information, :user, foreign_key: true
    change_column_default :information, :user_id, 0
  end
end
