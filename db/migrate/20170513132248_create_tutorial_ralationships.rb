class CreateTutorialRalationships < ActiveRecord::Migration[5.0]
  def change
    create_table :tutorial_relationships do |t|
      t.integer :tutorial_id
      t.integer :user_id

      t.timestamps
    end
  end
end
