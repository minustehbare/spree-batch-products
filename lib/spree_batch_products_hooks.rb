class BatchProductsHooks < Spree::ThemeSupport::HookListener
  # custom hooks go here
  Deface::Override.new(:virtual_path => "admin/shared/_product_sub_menu",
                     :name => "batch_products_admin_product_sub_tabs",
                     :insert_bottom => "[data-hook='admin_product_sub_tabs'], #admin_product_sub_tabs[data-hook]",
                     :text => "<%= tab(:product_datasheets, :label => :batch_updates) %>",
                     :disabled => false)
end
