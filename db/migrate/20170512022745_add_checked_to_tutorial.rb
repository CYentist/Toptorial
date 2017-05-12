class AddCheckedToTutorial < ActiveRecord::Migration[5.0]
  def change
    add_column :tutorials, :checked, :boolean, default: false
  end
end
