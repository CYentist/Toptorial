class AddUserDescriptionAndContact < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :description, :text
    add_column :users, :contact, :string
  end
end
