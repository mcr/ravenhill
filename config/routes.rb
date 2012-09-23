Ravenhill::Application.routes.draw do
  resources :guardians do
    as_routes
  end

  devise_for :guardians

  resources :students do
    as_routes
    collection do
      get 'welcome'
    end
  end

  root :to => "guardians#welcome"

end
