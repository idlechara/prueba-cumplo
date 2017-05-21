class AddPrivateKeytoUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :private_key, :text
  end
end
