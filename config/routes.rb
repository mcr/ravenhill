Ravenhill::Application.routes.draw do
  resources :guardians do
    as_routes
  end

  resources :students do
    as_routes
  end

end
