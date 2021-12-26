class CreatePhones < ActiveRecord::Migration[6.1]
  def change
    create_table :phones do |t|
      t.string :type, null: false
      t.string :digits, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
