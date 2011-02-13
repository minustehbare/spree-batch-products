class Admin::ProductDatasheetsController < Admin::BaseController
  def index
    @datasheets = ProductDatasheet.all
  end
  
  def upload
  end
end
