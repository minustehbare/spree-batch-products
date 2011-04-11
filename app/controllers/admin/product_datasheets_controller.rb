class Admin::ProductDatasheetsController < Admin::BaseController
  def index
    @product_datasheets = ProductDatasheet.not_deleted
  end
  
  def new
    @product_datasheet = ProductDatasheet.new
    render :layout => false
  end
  
  def show
    @product_datasheet = ProductDatasheet.find(params[:id])
    send_file @product_datasheet.xls.path
  end
  
  def upload
  end
  
  def edit
  end
  
  def destroy
    @product_datasheet = ProductDatasheet.find(params[:id])
    @product_datasheet.deleted_at = Time.now
    if @product_datasheet.save
      flash.notice = I18n.t("notice_messages.product_datasheet_deleted")
    else
      @product_datasheet.errors.add_to_base('Failed to delete the product datasheet')
    end
    redirect_to admin_product_datasheets_path
  end
  
  def clone
  end
  
  def collection
    return @collection if @collection
    
  end
  
  def create
    @product_datasheet = ProductDatasheet.create(params[:product_datasheet])
    if @product_datasheet.xls.original_filename.end_with?(".xls") and @product_datasheet.save
      Delayed::Job.enqueue(@product_datasheet)
      flash.notice = I18n.t("notice_messages.product_datasheet_saved")
      redirect_to admin_product_datasheets_path
    else
      @product_datasheets = ProductDatasheet.not_deleted
      render :template => 'admin/product_datasheets/index', :action => :new
    end
  end
end
