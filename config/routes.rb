Rails.application.routes.draw do
  resources :users, only: [:index, :show], defaults: { format: :json } do
    collection { get :me }
  end

  devise_for :users, defaults: { format: :json }, path: "auth",
                     path_names: {
                       sign_in: "login",
                       sign_out: "logout",
                     }, controllers: {
                       sessions: "auth/sessions",
                       registrations: "auth/registrations",
                     }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
