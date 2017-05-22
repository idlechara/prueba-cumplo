class RenameCteToCtd < ActiveRecord::Migration[5.1]
  def change
    rename_table :ctes, :ctds
  end
end
