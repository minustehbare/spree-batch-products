Rails.application.routes.draw do
  # Add your extension routes here
  namespace :admin do
    resources :product_datasheets do
    end
  end
end
