class AddUserIdToInformation < ActiveRecord::Migration[7.0]
  def change
    add_reference :information, :user, null: false, foreign_key: true
  end
end
