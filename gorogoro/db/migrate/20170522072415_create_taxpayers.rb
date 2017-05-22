class CreateTaxpayers < ActiveRecord::Migration[5.1]
  def change
    create_table :taxpayers do |t|
      t.string :rut
      t.string :business_name
      t.string :region

      t.timestamps
    end
  end
end
