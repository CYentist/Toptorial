class ChangeColunmName < ActiveRecord::Migration[5.0]
  def change
    rename_table :tutorial_ralationships, :tutorial_relationships
  end
end
