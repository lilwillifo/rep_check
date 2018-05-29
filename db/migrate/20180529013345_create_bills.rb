class CreateBills < ActiveRecord::Migration[5.1]
  def change
    create_table :bills do |t|
      t.string :bill_id
      t.integer :roll_call
      t.string :chamber
      t.integer :year
      t.integer :month
      t.integer :congress
      t.string :name
      t.integer :session
      t.string :democratic_majority_position
      t.string :republican_majority_position
    end
  end
end
