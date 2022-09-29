Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup',
    current_user: 'current_user'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  get '/current_user', to: 'current_user#index'
  resources :group_users, only: [:create, :destroy, :update, :assign_users_to_group]
  resources :groups, only: [:index, :show]
  post '/group_users/create_group', to: 'group_users#create_group'
  post '/group_users/:id', to: 'group_users#assign_user_to_group'
end
