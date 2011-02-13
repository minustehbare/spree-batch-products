class AddProcessedAtColumnToProductDatasheets < ActiveRecord::Migration
  def self.up
    add_column :product_datasheets, :processed_at, :datetime
  end

  def self.down
    remove_column :product_datasheets, :processed_at
  end
end
