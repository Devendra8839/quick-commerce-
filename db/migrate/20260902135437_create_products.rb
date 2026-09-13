class CreateProducts < ActiveRecord::Migration[8.1]
  def change
    create_table :products do |t|
      t.string :name
      t.references :category, null: false, foreign_key: true
      t.references :supplier, null: false, foreign_key: true
      t.decimal :price
      t.integer :stock

      t.timestamps
    end
  end
end
