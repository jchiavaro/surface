class AddContactsListIdToContact < ActiveRecord::Migration
  def change
    add_column :contacts, :contacts_list_id, :string
  end
end
