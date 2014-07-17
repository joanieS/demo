class AddActiveToInstallations < ActiveRecord::Migration
  def change
    add_column :installations, :active, :boolean, :default => false
  end
end
