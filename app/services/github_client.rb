class GithubClient
    include HTTParty
    base_uri 'https://api.github.com'
  
    def initialize(query_params)      
      @sort = query_params[:sort]
      @order = query_params[:order]
      @page = query_params[:page]
      @per_page = query_params[:per_page] ? query_params[:per_page] : 10
      @query_string = create_query_string(query_params.except(:order, :sort, :page, :per_page))
    end
  
    def repos
      repos = self.class.get("/search/repositories?q=#{@query_string}&sort=#{@sort}&order=#{@order}&page=#{@page}&per_page=#{@per_page}")
      
      return repos
    end

    private

    def create_query_string(query_params)
      query_string = ""    

      language = query_params['language'].present? ? "" : "ruby"
      query_string << language

      query_params.each do |key, value|
        query_string << "+#{key}:#{value}"
      end

      return query_string
    end
end