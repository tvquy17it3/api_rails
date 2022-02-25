Rails.application.routes.draw do
  devise_for :users
  namespace :api do
    namespace :v1 do
      devise_scope :user do
        post "sign_up", :to => 'registration#create'
        post "sign_in", :to => 'session#create'
        delete "sign_out", :to => 'session#destroy'
        get "show", :to => 'user#show'
        post "update", :to => 'user#update'
        post "change_password", :to => 'user#change_password'
      end
    end
  end
end
