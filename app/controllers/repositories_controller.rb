class RepositoriesController < ApplicationController
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

    render json: response
  end
end