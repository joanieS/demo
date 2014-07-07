class CreateBeacons < ActiveRecord::Migration
  def change
    create_table :beacons do |t|
      t.integer :minor_id
      t.text :content
      t.string :type
      t.string :audio
      t.integer :installation_id

      t.timestamps
    end
  end
end
