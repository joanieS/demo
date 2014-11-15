class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :unique_id

      t.timestamps
    end
  end
end
