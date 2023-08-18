Rails.application.routes.draw do
  resources :morph_images, only: [:new, :create, :show]
end
