class AddPriceToTutorial < ActiveRecord::Migration[5.0]
  def change
    add_column :tutorials, :price, :integer
  end
end
