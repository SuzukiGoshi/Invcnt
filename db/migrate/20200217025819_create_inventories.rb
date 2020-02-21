class CreateInventories < ActiveRecord::Migration[6.0]
  def change
    create_table :inventories do |t|

      t.string :name, null: false # 在庫名
      t.integer :stock, default: 0 # 在庫数
      t.boolean :not_used, null: false, default: false # 使用フラグ
      t.timestamps
    end

    add_index :inventories, "LOWER(name)", unique: true
  end
end
