require "rails_helper"

params = {}

describe 'GithubClient' do
  context 'when per_page is not passed as params' do
    it 'should get 10 first public repos' do
        repos = GithubClient.new(params).repos      
        expect(repos['items'].count).to eq(10)
    end
  end

  context 'when per_page is set to 20' do
    it 'should get 20 first public repos' do
      params = {
        per_page: 20
      }

      repos = GithubClient.new(params).repos      
      expect(repos['items'].count).to eq(20)
    end
  end

  context 'when language is not set' do
    it 'should get ruby as default' do
      repos = GithubClient.new(params).repos
     
      expect(repos['items'][0]['language']).to eq('Ruby')
    end
  end

  context 'when language is set to JavaScript' do
    it 'should get JavaScript repos' do
      params = {
        language: 'javascript'
      }

      repos = GithubClient.new(params).repos

      expect(repos['items'][0]['language']).to eq('JavaScript')
    end
  end
end