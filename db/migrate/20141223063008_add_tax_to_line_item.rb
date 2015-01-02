class AddTaxToLineItem < ActiveRecord::Migration
  def up
    add_column :line_items, :tax, :float
  end

  def down
    remove_column :line_items, :tax
  end
end
