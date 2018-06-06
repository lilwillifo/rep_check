class AddTimestampsToRepVotes < ActiveRecord::Migration[5.1]
  def change
    add_column :rep_votes, :created_at, :datetime
    add_column :rep_votes, :updated_at, :datetime
  end
end
