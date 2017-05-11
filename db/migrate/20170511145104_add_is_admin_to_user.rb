class AddIsAdminToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :is_admin, :boolean, default: false
  end
end
