class CreateBills < ActiveRecord::Migration[5.1]
  def change
    create_table :bills do |t|
      t.string :roll_call
      t.string :name
      t.integer :session
      t.string :democratic_majority_position
      t.string :republican_majority_position
      t.string :colorado_positions
    end
  end
end
