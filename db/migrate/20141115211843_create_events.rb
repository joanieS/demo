class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :type

      t.timestamps
    end
  end
end
