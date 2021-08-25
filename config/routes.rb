Rails.application.routes.draw do
  get '/authorization', to: 'authorizations#build_jwt'
  get '/repositories', to: 'repositories#index'
end
