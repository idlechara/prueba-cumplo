class CreateCtds < ActiveRecord::Migration[5.0]
  def change
    create_table :ctds do |t|
      t.string :source
      t.string :source_rut
      t.string :destination
      t.string :destination_rut
      t.datetime :transfer_date
      t.integer :folio
      t.integer :amount
      t.string :state

      t.timestamps
    end
  end
end
