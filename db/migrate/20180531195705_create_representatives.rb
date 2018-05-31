class CreateRepresentatives < ActiveRecord::Migration[5.1]
  def change
    create_table :representatives do |t|
      t.integer :disctrict
      t.string :name
      t.string :facebook
      t.string :twitter
      t.string :email
      t.string :website
      t.string :bioguide_id
    end
  end
end
