class DropLineitemTable < ActiveRecord::Migration
  def up
    drop_table :line_items

    create_table :line_items do |t|
      t.references :order
      t.references :product
      t.float :unit_price
      t.integer :qty
      t.float :tax
      t.float :total
      t.timestamps
    end
  end

  def down
    drop_table :line_items

    create_table :line_items do |t|
      t.references :order_id
      t.references :product_id
      t.float :unit_price
      t.integer :qty
      t.float :total
      t.float :tax
      t.timestamps
    end
  end
end
