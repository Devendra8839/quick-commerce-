class CreateAddresses < ActiveRecord::Migration[8.1]
  def change
    create_table :addresses do |t|
      t.references :user, null: false, foreign_key: true
      t.string :city
      t.string :state
      t.string :address_type

      t.timestamps
    end
  end
end
