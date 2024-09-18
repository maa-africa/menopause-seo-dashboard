class KeywordsController < ApplicationController
  before_action :set_keyword, only: [:show, :edit, :update, :destroy, :fetch_serp]

  # GET /keywords or /keywords.json
  def index
    @keywords = Keyword.all
  end

  # GET /keywords/1 or /keywords/1.json
  def show
    begin
      @serp_results = SerpapiService.new.search_keyword_ranking(@keyword.name)
    rescue StandardError => e
      Rails.logger.error("Error fetching SERP data for keyword '#{@keyword.name}': #{e.message}")
      @serp_results = []
      flash[:alert] = "An error occurred while fetching SERP data."
    end
  end

  # GET /keywords/new
  def new
    @keyword = Keyword.new
  end

  # GET /keywords/1/edit
  def edit
  end

  # POST /keywords or /keywords.json
  def create
    @keyword = Keyword.new(keyword_params)

    respond_to do |format|
      if @keyword.save
        format.html { redirect_to keyword_url(@keyword), notice: 'Keyword was successfully created.' }
        format.json { render :show, status: :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @keyword.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /keywords/1 or /keywords/1.json
  def update
    respond_to do |format|
      if @keyword.update(keyword_params)
        format.html { redirect_to keyword_url(@keyword), notice: 'Keyword was successfully updated.' }
        format.json { render :show, status: :ok }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @keyword.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /keywords/1 or /keywords/1.json
  def destroy
    @keyword.destroy!

    respond_to do |format|
      format.html { redirect_to keywords_url, notice: 'Keyword was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # Use the SerpapiService to fetch SERP data
  def fetch_serp
    service = SerpapiService.new
    @serp_results = service.search_keyword_ranking(@keyword.name)
  
    if @serp_results.empty?
      flash[:alert] = "No SERP data found for keyword: #{@keyword.name}."
    end
  rescue StandardError => e
    Rails.logger.error("Error fetching SERP data: #{e.message}")
    flash[:alert] = "An error occurred while fetching SERP data: #{e.message}"
    @serp_results = []
  end
  

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_keyword
    @keyword = Keyword.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Keyword not found."
    redirect_to keywords_url
  end

  # Only allow a list of trusted parameters through.
  def keyword_params
    params.require(:keyword).permit(:name, :target_url, :search_engine)
  end
end