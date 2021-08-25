Rails.application.routes.draw do
  get '/repositories', to: 'repositories#index'
end
