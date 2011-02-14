class AddDeletedAtColumnToProductDatasheets < ActiveRecord::Migration
  def self.up
    add_column :product_datasheets, :deleted_at, :datetime
  end

  def self.down
    remove_column :product_datasheets, :deleted_at
  end
end
