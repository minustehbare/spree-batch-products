class BatchProductsHooks < Spree::ThemeSupport::HookListener
  # custom hooks go here
  insert_after :admin_product_sub_tabs do
    %(<%= tab(:product_datasheets, :label => :batch_updates) %>)
  end
end
