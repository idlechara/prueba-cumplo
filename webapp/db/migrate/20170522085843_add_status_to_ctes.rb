class AddStatusToCtes < ActiveRecord::Migration[5.1]
  def change
    add_column :ctds, :status, :string
  end
end
