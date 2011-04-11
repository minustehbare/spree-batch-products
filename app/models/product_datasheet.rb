class ProductDatasheet < ActiveRecord::Base
  require 'spreadsheet'
  
  has_attached_file :xls, :path => ":rails_root/uploads/product_datasheets/:id/:basename.:extension"  
  
  validates_attachment_presence :xls
  validates_attachment_content_type :xls, :content_type => ['application/vnd.ms-excel','text/plain']
  
  scope :not_deleted, where("product_datasheets.deleted_at is NULL")
  scope :deleted, where("product_datasheets.deleted_at is NOT NULL")
  
  def path
    "#{Rails.root}/uploads/product_datasheets/#{self.id}/#{self.xls_file_name}"
  end
  
  def perform
    workbook = Spreadsheet.open self.path
    worksheet = workbook.worksheet(0)
    columns = [worksheet.dimensions[2], worksheet.dimensions[3]]
    headers = worksheet.row(0)
    
    worksheet.each do |row|
      attr_hash = {}
      for i in columns[0]..columns[1]
        attr_hash[headers[i]] = row[i] unless row[i].nil?# or row[i].empty?
      end
      if Product.has_attribute?("#{headers[0]}")
        process_products("#{headers[0]}", row[0], attr_hash)
      elsif Variant.has_attribute?("#{headers[0]}")
        process_variants("#{headers[0]}", row[0], attr_hash)
      else
        #TODO do something when the batch update for the row in question is invalid
      end
    end
    
    self.update_attribute('processed_at', Time.now)
  end
  
  def process_products(key, value, attr_hash)
    products_to_update = Products.not_deleted.where(key => value).all
    products_to_update.each { |product| product.update_attributes attr_hash }
  end
  
  def process_variants(key, value, attr_hash)
    variants_to_update = Variants.not_deleted.where(key => value).all
    variants_to_update.each { |variant| variant.update_attributes attr_hash }
  end
  
  def processed?
    !self.processed_at.nil?
  end
  
  def deleted?
    !self.deleted_at.nil?
  end
end
