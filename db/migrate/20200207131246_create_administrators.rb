class CreateAdministrators < ActiveRecord::Migration[6.0]
  def change
    create_table :administrators do |t|
      t.string :inv_id, null: false # ID
      t.string :hashed_password # パスワード
      t.boolean :suspended, null: false, default: false # 無効フラグ

      t.timestamps
    end

    add_index :administrators, "LOWER(inv_id)", unique: true
  end
end
