class DashboardController < ApplicationController
  def index
    @keyword_results = Search.all # or whatever logic you use to fetch the results
  end
end