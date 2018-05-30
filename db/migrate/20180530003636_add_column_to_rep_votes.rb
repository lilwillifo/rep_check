class AddColumnToRepVotes < ActiveRecord::Migration[5.1]
  def change
    add_column :rep_votes, :vote_with, :integer, :default => 0
  end
end
