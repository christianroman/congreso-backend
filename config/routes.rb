Congreso::Application.routes.draw do

  namespace :admin do

      root :to => 'members#index'

      controller :sessions do
        get  'login' => :new
        post 'login' => :create
        delete 'logout' => :destroy
      end

      resources :users
      resources :states
      resources :members
      resources :commissions
  end

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :members do
        collection do
          
          get 'nearby'
          get 'diputados'
          get 'senadores'

          match '/:id/initiatives', :to => 'members#initiatives'
          match '/:id/votes', :to => 'members#votes'
          match '/:id/attendances', :to => 'members#attendances'

	      end
      end

      resources :commissions

    end
  end

end
