class DropOrdersTable < ActiveRecord::Migration
  def up
    drop_table :orders

    create_table :orders do |t|
      t.text :billing_address
      t.text :shipping_address
      t.string :status
      t.references :user
      t.timestamps
    end
  end

  def down
    drop_table :orders

    create_table :orders do |t|
      t.string :status
      t.references :line_items
      t.timestamps
    end
  end
end
