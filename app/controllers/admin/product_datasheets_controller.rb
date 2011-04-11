class Admin::ProductDatasheetsController < Admin::BaseController
  def index
    @product_datasheets = ProductDatasheet.not_deleted
  end
  
  def new
    @product_datasheet = ProductDatasheet.new
    render :layout => false
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
    redirect_to admin_product_datasheets_path
  end
  
  def clone
  end
  
  def collection
    return @collection if @collection
    
  end
  
  def create
    product_datasheet = ProductDatasheet.create(params[:product_datasheet])
    if product_datasheet.xls.original_filename.end_with?(".xls")
      if product_datasheet.save
        flash.notice = I18n.t("notice_messages.product_datasheet_saved")
      end
    else
      flash.notice = I18n.t("notice_messages.invalid_product_datasheet_extension")
    end
    redirect_to admin_product_datasheets_path
  end
end
