class CreateBeacons < ActiveRecord::Migration
  def change
    create_table :beacons do |t|
      t.string :name
      t.text :content
      t.string :type
      t.text :audio

      t.timestamps
    end
  end
end
