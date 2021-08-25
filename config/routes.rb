Rails.application.routes.draw do
  namespace :v1 do
    get '/authorization', to: 'authorizations#build_jwt'
    get '/repositories', to: 'repositories#index'
  end
end
