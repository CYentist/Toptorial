class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.integer :total, default: 0
      t.integer :user_id
      t.text :question
      t.string :contact
      t.timestamps
    end
  end
end
