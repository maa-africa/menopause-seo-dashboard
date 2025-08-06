# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Create sample keywords for menopause SEO tracking
sample_keywords = [
  {
    name: "menopause symptoms",
    keyword: "menopause symptoms",
    target_url: "https://example.com/menopause-symptoms",
    search_engine: "Google"
  },
  {
    name: "perimenopause",
    keyword: "perimenopause",
    target_url: "https://example.com/perimenopause",
    search_engine: "Google"
  },
  {
    name: "hormone replacement therapy",
    keyword: "hormone replacement therapy",
    target_url: "https://example.com/hrt",
    search_engine: "Google"
  },
  {
    name: "menopause hot flashes",
    keyword: "menopause hot flashes",
    target_url: "https://example.com/hot-flashes",
    search_engine: "Bing"
  },
  {
    name: "natural menopause remedies",
    keyword: "natural menopause remedies",
    target_url: "https://example.com/natural-remedies",
    search_engine: "Google"
  }
]

sample_keywords.each do |keyword_data|
  Keyword.find_or_create_by!(name: keyword_data[:name]) do |keyword|
    keyword.keyword = keyword_data[:keyword]
    keyword.target_url = keyword_data[:target_url]
    keyword.search_engine = keyword_data[:search_engine]
  end
end

puts "Created #{Keyword.count} sample keywords for menopause SEO tracking"
