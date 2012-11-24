Ravenhill::Application.routes.draw do
  devise_for :guardians

  namespace :admin do
    resources :guardians do
      as_routes
      resources :students do
	as_routes
      end
    end
    
    resources :teachers do
      as_routes
      resources :students do
	as_routes
      end
    end
    
    resources :students do
      as_routes
    end
  end

  resources :guardians do
    as_routes
    collection do
      get 'welcome'
    end
    member do
      get  'optin' 
      post 'confirm_optin'
      get  'wrongemail'
      post 'confirm_wrongemail'
    end
    resources :students do
      as_routes
    end
  end

  resources :teachers do
    as_routes
    resources :students do
      as_routes
    end
  end

  resources :students do
    as_routes
  end

  root :to => "guardians#welcome"

end
