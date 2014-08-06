class AddImageToInstallations < ActiveRecord::Migration
  def self.up
    add_attachment :installations, :image
  end

  def self.down
    remove_attachment :installations, :image
  end
end
