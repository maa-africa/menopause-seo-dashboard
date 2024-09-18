# app/services/serpapi_service.rb
class SerpapiService
  def initialize
    @client = GoogleSearchResults.new(api_key: ENV["SERPAPI_API_KEY"]) # Make sure the API key is correct
  end

  def search_keyword_ranking(keyword)
    Rails.logger.debug("Searching SERP for keyword: #{keyword}")
    
    begin
      response = @client.get_json({
        q: keyword,
        engine: "google",
        google_domain: "google.com",
        hl: "en"
      })

      Rails.logger.debug("SERP API response: #{response.inspect}")

      return parse_results(response)
    rescue StandardError => e
      Rails.logger.error("Error fetching SERP data: #{e.message}")
      return []
    end
  end

  private

  def parse_results(response)
    return [] if response['organic_results'].nil?

    response['organic_results'].map do |result|
      {
        title: result['title'],
        link: result['link'],
        snippet: result['snippet'],
        rank: result['position']
      }
    end
  end
end
