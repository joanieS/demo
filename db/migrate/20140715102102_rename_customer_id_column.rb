class RenameCustomerIdColumn < ActiveRecord::Migration
  def change
  	rename_column :installations, :customer_id, :user_id
  end
end
