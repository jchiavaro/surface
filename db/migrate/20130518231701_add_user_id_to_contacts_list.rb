class AddUserIdToContactsList < ActiveRecord::Migration
  def change
    add_column :contacts_lists, :user_id, :integer
  end
end
