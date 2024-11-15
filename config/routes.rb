Rails.application.routes.draw do
  # Rutas para el sistema de autenticación
  get "login", to: "auth#new", as: :login
  post "login", to: "auth#create"
  delete "logout", to: "auth#destroy", as: :logout

  # Rutas para ProductsUploadController
  get "products_upload/new", to: "products_upload#new", as: :new_products_upload
  post "products_upload", to: "products_upload#create", as: :create_products_upload
  get "products_upload/:id", to: "products_upload#show", as: :products_upload
  delete "products_upload/:id", to: "products_upload#destroy", as: :delete_products_upload
  get "products_upload/:id/edit", to: "products_upload#edit", as: :edit_products_upload
  patch "products_upload/:id", to: "products_upload#update", as: :update_products_upload

  resource :carts, only: [:show, :create, :destroy]
  resource :orders, only: [:create]

  # Rutas públicas para productos (solo index y show para los usuarios)
  resources :products, only: [:index, :show]

  # Ruta principal
  get "home/index"
  root "home#index"

  # Rutas para categorías
  get "category/laptops", to: "products#laptops", as: :laptops
  get "category/computadoras", to: "products#computadoras", as: :computadoras
  get "category/celulares", to: "products#celulares", as: :celulares
  get "category/accesorios", to: "products#accesorios", as: :accesorios
end
