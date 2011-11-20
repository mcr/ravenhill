Ravenhill::Application.routes.draw do
  resources :students do
    as_routes
  end

end
