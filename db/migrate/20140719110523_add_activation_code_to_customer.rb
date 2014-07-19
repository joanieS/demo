class AddActivationCodeToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :activation_code, :string, default: "", null: false
  end
end
