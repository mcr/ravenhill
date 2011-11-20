Ravenhill::Application.routes.draw do
  resources :guardians

  resources :students do
    as_routes
  end

end
