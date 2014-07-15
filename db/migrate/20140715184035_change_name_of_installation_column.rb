class ChangeNameOfInstallationColumn < ActiveRecord::Migration
  def change
  	rename_column :installations, :user_id, :customer_id
  end
end
