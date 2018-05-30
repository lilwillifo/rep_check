class CreateRepVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :rep_votes do |t|
      t.string :rep_name
      t.references :bill, foreign_key: true
    end
  end
end
