class AddTimestampsToRepresentative < ActiveRecord::Migration[5.1]
  def change
    add_column :representatives, :created_at, :datetime
    add_column :representatives, :updated_at, :datetime
  end
end
