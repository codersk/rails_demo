class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.references :order_id
      t.references :product_id
      t.float :unit_price
      t.integer :qty
      t.float :total
      t.timestamps
    end
  end
end
