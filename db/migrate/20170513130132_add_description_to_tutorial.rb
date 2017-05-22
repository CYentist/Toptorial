class AddDescriptionToTutorial < ActiveRecord::Migration[5.0]
  def change
    add_column :tutorials, :description, :text
  end
end
