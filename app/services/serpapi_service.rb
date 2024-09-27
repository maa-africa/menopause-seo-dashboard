# app/services/serpapi_service.rb
require 'uri'
require 'net/http'
require 'json'

class SerpapiService
  def initialize
    @url = URI("https://api.serphouse.com/serp/live")
    @http = Net::HTTP.new(@url.host, @url.port)
    @http.use_ssl = true
    @http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    @headers = {
      "accept" => 'application/json',
      "content-type" => 'application/json',
      "authorization" => "Bearer #{ENV['SERPHOUSE_API_TOKEN']}"
    }
  end

  def search_keyword_ranking(keyword)
    Rails.logger.debug("Searching SERP for keyword: #{keyword}")

    request = Net::HTTP::Post.new(@url, @headers)
    request.body = {
      data: {
        domain: "google.com",
        lang: "en",
        q: keyword,
        loc: "Texas,United States",
        device: "desktop",
        serp_type: "web"
      }
    }.to_json

    begin
      response = @http.request(request)
      Rails.logger.debug("SERP API response: #{response.body}")

      return parse_results(JSON.parse(response.body))
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