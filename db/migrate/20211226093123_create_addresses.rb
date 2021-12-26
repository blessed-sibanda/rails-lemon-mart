class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.string :line1, null: false
      t.string :line2
      t.string :city, null: false
      t.string :state, null: false
      t.string :zip, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
