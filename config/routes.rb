Rails.application.routes.draw do
  root 'people#index'

  resources :people do
    resources :animals
  end
end
