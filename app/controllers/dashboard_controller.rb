class DashboardController < ApplicationController
  def index
    @keywords = Keyword.all
    @total_keywords = @keywords.count
    @search_engines = @keywords.group(:search_engine).count
  end
end
