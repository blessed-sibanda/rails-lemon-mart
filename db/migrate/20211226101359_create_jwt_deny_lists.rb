class CreateJwtDenyLists < ActiveRecord::Migration[6.1]
  def change
    create_table :jwt_deny_lists do |t|
      t.string :jti
      t.datetime :expired_at
      t.string :exp

      t.timestamps
    end
    add_index :jwt_deny_lists, :jti
  end
end
