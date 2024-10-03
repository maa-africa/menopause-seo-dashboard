class SearchesController < ApplicationController
  def index
    @query = params[:query]
    if @query.present?
      client = GoogleSearch.new(q: @query, api_key: SERP_API_KEY)
      @results = client.get_hash[:organic_results]
      @ranking = calculate_ranking(@results)
      
      # Save the search results
      Search.create(query: @query, results: @results, ranking: @ranking)
    end
  rescue StandardError => e
    flash.now[:alert] = "An error occurred: #{e.message}"
    @results = []
    @ranking = {}
  end

  def dashboard
    @keyword_results = Search.group(:query).average(:ranking).map do |keyword, avg_ranking|
      { keyword: keyword, ranking: avg_ranking.to_f.round(2) }
    end
  end

  private

  def calculate_ranking(results)
    results.each_with_object({}).with_index do |(result, ranking), index|
      ranking[result[:link]] = index + 1
    end
  end
end