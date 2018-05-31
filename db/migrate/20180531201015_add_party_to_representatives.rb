class AddPartyToRepresentatives < ActiveRecord::Migration[5.1]
  def change
    add_column :representatives, :party, :integer, :default => 0
  end
end
