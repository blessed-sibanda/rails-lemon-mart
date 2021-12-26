Rails.application.routes.draw do
  devise_for :users, defaults: { format: :json }, path: "v1",
                     path_names: {
                       sign_in: "auth/login",
                       sign_out: "auth/logout",
                     }, controllers: {
                       sessions: "auth/sessions",
                     }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
