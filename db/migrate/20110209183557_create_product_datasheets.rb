class CreateProductDatasheets < ActiveRecord::Migration
  def self.up
    create_table :product_datasheets do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :product_datasheets
  end
end
