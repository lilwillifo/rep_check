class AddCategoriesToBills < ActiveRecord::Migration[5.1]
  def change
    add_reference :bills, :category, foreign_key: true
  end
end
