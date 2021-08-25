class V1::RepositoriesController < V1::ApplicationController
  before_action :require_jwt

  def index    
    repos = GithubClient.new(request.query_parameters).repos
    response = []

    repos['items'].map do |repo|
       response << { 
          full_name: repo['full_name'],
          description: repo['description'],
          stargazers_count: repo['stargazers_count'],
          forks_count: repo['forks_count'],
          author_name: repo['owner']['login']
       }
    end

    render json: {page: request.query_parameters[:page], data: response }
  end

  private 

  def require_jwt
    token = request.headers["HTTP_AUTHORIZATION"]
    if !token
      head :forbidden
    end
    if !valid_token(token)
      head :forbidden
    end
  end

  private
  
  def valid_token(token)
    unless token
      return false
    end

    token.gsub!('Bearer ','')
    begin      
      decoded_token = JWT.decode token, ENV["JWT_SECRET"], true
      return true
    rescue JWT::DecodeError
      Rails.logger.warn "Error decoding the JWT"
    end
    false
  end
end