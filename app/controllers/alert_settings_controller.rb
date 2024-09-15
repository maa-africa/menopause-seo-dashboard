class AlertSettingsController < ApplicationController
  before_action :set_alert_setting, only: %i[ show edit update destroy ]

  # GET /alert_settings or /alert_settings.json
  def index
    @alert_settings = AlertSetting.all
  end

  # GET /alert_settings/1 or /alert_settings/1.json
  def show
  end

  # GET /alert_settings/new
  def new
    @alert_setting = AlertSetting.new
  end

  # GET /alert_settings/1/edit
  def edit
  end

  # POST /alert_settings or /alert_settings.json
  def create
    @alert_setting = AlertSetting.new(alert_setting_params)

    respond_to do |format|
      if @alert_setting.save
        format.html { redirect_to alert_setting_url(@alert_setting), notice: "Alert setting was successfully created." }
        format.json { render :show, status: :created, location: @alert_setting }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @alert_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /alert_settings/1 or /alert_settings/1.json
  def update
    respond_to do |format|
      if @alert_setting.update(alert_setting_params)
        format.html { redirect_to alert_setting_url(@alert_setting), notice: "Alert setting was successfully updated." }
        format.json { render :show, status: :ok, location: @alert_setting }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @alert_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alert_settings/1 or /alert_settings/1.json
  def destroy
    @alert_setting.destroy!

    respond_to do |format|
      format.html { redirect_to alert_settings_url, notice: "Alert setting was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alert_setting
      @alert_setting = AlertSetting.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def alert_setting_params
      params.require(:alert_setting).permit(:keyword_id, :threshold, :notification_method)
    end
end
