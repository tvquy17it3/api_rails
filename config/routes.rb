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
        resources :timesheets, only: %i(show create) do
            get 'list', on: :collection
        end
        get 'timesheet-details/:id', :to => 'timesheets#details'
        delete "timesheets/:id", :to => 'timesheets#soft_delete'
      end
    end
  end
  namespace :admin do
    resources :users
  end
end
