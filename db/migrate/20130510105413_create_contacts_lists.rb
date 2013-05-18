class CreateContactsLists < ActiveRecord::Migration
  def change
    create_table :contacts_lists do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
