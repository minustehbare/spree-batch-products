class Admin::ProductDatasheetsController < Admin::BaseController
  def index
    @datasheets = ProductDatasheet.not_deleted
  end
  
  def upload
  end
  
  def edit
  end
  
  def destroy
    datasheet = ProductDatasheet.find_by_id(params[:id])
    datasheet.deleted_at = Time.now
    if datasheet.save
      flash.notice = I18n.t("notice_messages.product_datasheet_deleted")
    else
      flash.notice = I18n.t("notice_messages.product_datasheet_not_deleted")
    end
  end
  
  def clone
  end
  
  def collection
    return @collection if @collection
    
  end
end
