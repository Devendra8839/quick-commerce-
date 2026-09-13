class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.decimal :salary
      t.references :department, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
