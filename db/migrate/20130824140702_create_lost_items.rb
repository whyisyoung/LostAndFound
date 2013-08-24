class CreateLostItems < ActiveRecord::Migration
  def change
    create_table :lost_items do |t|
      t.datetime :lost_time
      t.text :detail
      t.string :finder
      t.integer :phone
      t.string :status
      t.string :place
      t.integer :category_id
      t.integer :user_id

      t.timestamps
    end
    add_index :lost_items, [ :user_id, :created_at ]
  end
end
