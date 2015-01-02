class AddTaxRateToProducts < ActiveRecord::Migration
  def up
    add_column :products, :tax_rate, :decimal
  end

  def down
    add_column :products, :tax_rate
  end
end
