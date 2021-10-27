Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :accounts
  resources :books

  namespace :api do
    namespace :v1 do
      resources :books, only: %i[index show create]
      post '/login', to: 'authentication#login'
      get '/*a', to: 'api_base#not_found'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
