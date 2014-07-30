class AddImageUrLtoInstallations < ActiveRecord::Migration
  def change
  	add_column :installations, :image_url, :string
  end
end
