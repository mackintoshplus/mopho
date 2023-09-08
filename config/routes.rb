Rails.application.routes.draw do
  namespace :admin do
    get 'dashboard/index'
  end
  resources :morph_images, only: [:new, :create, :show]
end
