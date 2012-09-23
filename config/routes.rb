Ravenhill::Application.routes.draw do
  devise_for :guardians

  resources :guardians do
    as_routes
    collection do
      get 'welcome'
    end
  end

  resources :students do
    as_routes
  end

  root :to => "guardians#welcome"

end
