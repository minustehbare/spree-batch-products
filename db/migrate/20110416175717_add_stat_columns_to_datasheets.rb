class AddStatColumnsToDatasheets < ActiveRecord::Migration
  def self.up
    add_column :product_datasheets, :matched_records, :integer
    add_column :product_datasheets, :updated_records, :integer
    add_column :product_datasheets, :failed_records, :integer
    add_column :product_datasheets, :failed_queries, :integer
  end

  def self.down
    add_column :product_datasheets, :matched_records
    add_column :product_datasheets, :updated_records
    add_column :product_datasheets, :failed_records
    add_column :product_datasheets, :failed_queries
  end
end
