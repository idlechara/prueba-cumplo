class CreateCtes < ActiveRecord::Migration[5.1]
  def change
    create_table :ctes do |t|
      t.integer :amount
      t.references :sender
      t.references :recipient
      t.text :document
      t.datetime :transfer_timestamp
      t.string :folio
      t.timestamps
    end
  end
end
