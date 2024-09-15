class Keyword < ApplicationRecord
  require "google_search_results" # Ensure you require the gem at the top of your model or in an initializer

  # Method to fetch SERP results
  def fetch_serp_results
    client = GoogleSearch.new({
      q: self.name, # Use the keyword name for the search query
      hl: "en",
      google_domain: "google.com",
      api_key: ENV["SERP_API_KEY"] # Ensure the API key is stored in an environment variable
      # device: device # Can be 'desktop', 'mobile', or 'tablet'
    })

    results = client.get_hash

    # Debugging: Print results to log
    Rails.logger.debug("SERP Results: #{results.inspect}")

    # Extract rankings if results and 'organic_results' are present
    rankings = if results && results["organic_results"]
      results["organic_results"].map.with_index(1) do |result, index|
        {
          rank: index,
          title: result["title"],
          link: result["link"],
          snippet: result["snippet"]
        }
      end
    else
      []
    end

    rankings
  end
end
