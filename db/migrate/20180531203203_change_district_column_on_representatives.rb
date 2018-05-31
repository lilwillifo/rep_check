class ChangeDistrictColumnOnRepresentatives < ActiveRecord::Migration[5.1]
  def change
    rename_column :representatives, :disctrict, :district
  end
end
