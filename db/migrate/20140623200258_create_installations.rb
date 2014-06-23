class CreateInstallations < ActiveRecord::Migration
  def change
    create_table :installations do |t|
      t.string :name
      t.string :group
      t.belongs_to :customer, index: true

      t.timestamps
    end
  end
end
