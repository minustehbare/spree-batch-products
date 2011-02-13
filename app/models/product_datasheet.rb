sclass ProductDatasheet < ActiveRecord::Base
  require 'spreadsheet'
  
  has_attached_file :xls, :path => ":rails_root/uploads/product_datasheets/:id/:basename.:extension"  
  
  validates_attachment_presence :xls
  validates_attachment_content_type :xls, :content_type => ['application/vnd.ms-excel','text/plain']
  
  def path
    "#{Rails.root}/uploads/product_datasheets/#{self.id}/#{self.xls_file_name}"
  end
  
  def process
    sheet = SpreadSheet.open self.path
    columns = [sheet.dimensions[2], sheet.dimensions[3]]
    headers = sheet.dimensions[0]
    
    sheet.each do |row|
      attr_hash = {}
      for i in columns[0]..columns[1]
        attr_hash[headers[i]] = row[i] unless row[i].nil? or row[i].empty?
      end
      Product.where("#{headers[0]}" => row[0]).all.each do |product|
        product.update_attributes attr_hash
      end
    end
    
    self.update_attribute('processed_at', Time.now)
  end
  
  def upload
  end
  
end
