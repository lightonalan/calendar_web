Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root "pages#home"

  get "privacy", to: "pages#privacy", as: :privacy
  get "terms", to: "pages#terms", as: :terms
  get "support", to: "pages#support", as: :support

  namespace :api do
    namespace :v1 do
      get "app", to: "app#info"
    end
  end
end
