class AddDocToCdt < ActiveRecord::Migration[5.0]
  def change
    add_column :ctds, :doc, :text
  end
end
