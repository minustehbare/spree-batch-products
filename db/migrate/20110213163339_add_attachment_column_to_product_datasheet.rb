class AddAttachmentColumnToProductDatasheet < ActiveRecord::Migration
  def self.up
    add_column :product_datasheets, :xls_file_name, :string
    add_column :product_datasheets, :xls_file_size, :integer
    add_column :product_datasheets, :xls_content_type, :string
  end

  def self.down
    remove_column :product_datasheets, :xls_file_name
    remove_column :product_datasheets, :xls_file_size
    remove_column :product_datasheets, :xls_content_type
  end
end
