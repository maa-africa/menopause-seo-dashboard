class KeywordsController < ApplicationController
  before_action :set_keyword, only: [ :show, :edit, :update, :destroy, :fetch_serp ]

  # GET /keywords or /keywords.json
  def index
    @keywords = Keyword.all
  end

  # GET /keywords/1 or /keywords/1.json
  def show
    @serp_results = @keyword.fetch_serp_results
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
        format.html { redirect_to keyword_url(@keyword), notice: "Keyword was successfully created." }
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
        format.html { redirect_to keyword_url(@keyword), notice: "Keyword was successfully updated." }
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
      format.html { redirect_to keywords_url, notice: "Keyword was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # Use the google_search_results gem to get SERP data
  def fetch_serp
    @serp_results = @keyword.fetch_serp_results
    # Do something with @serp_results if needed
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_keyword
      @keyword = Keyword.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def keyword_params
      params.require(:keyword).permit(:name, :target_url, :search_engine)
    end
end
