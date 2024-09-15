class Keyword < ApplicationRecord
  require 'google_search_results' # Ensure you require the gem at the top of your model or in an initializer

  # Method to fetch SERP results
  def fetch_serp_results
    client = GoogleSearch.new({
      q: self.name, # Use the keyword name for the search query
      hl: "en",
      gl: "us",
      google_domain: "google.com",
      api_key: ENV['SERP_API_KEY'] # Ensure the API key is stored in an environment variable
    })

    client.get_hash
  end
end
