Rails.application.routes.draw do
  devise_for :users
  namespace :api do
    namespace :v1 do
      devise_scope :user do
        post "sign_up", :to => 'registration#create'
        post "sign_in", :to => 'session#create'
        post "sign_out", :to => 'session#destroy'
        get "show", :to => 'session#show'
      end
    end
  end
end
