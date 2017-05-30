class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
      t.integer :user_id
      t.string :title
      t.text :description
      t.string :contact
      t.integer :price
      t.boolean :public, default: true
      t.timestamps
    end
  end
end
