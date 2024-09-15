require "test_helper"

class AlertSettingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @alert_setting = alert_settings(:one)
  end

  test "should get index" do
    get alert_settings_url
    assert_response :success
  end

  test "should get new" do
    get new_alert_setting_url
    assert_response :success
  end

  test "should create alert_setting" do
    assert_difference("AlertSetting.count") do
      post alert_settings_url, params: { alert_setting: { keyword_id: @alert_setting.keyword_id, notification_method: @alert_setting.notification_method, threshold: @alert_setting.threshold } }
    end

    assert_redirected_to alert_setting_url(AlertSetting.last)
  end

  test "should show alert_setting" do
    get alert_setting_url(@alert_setting)
    assert_response :success
  end

  test "should get edit" do
    get edit_alert_setting_url(@alert_setting)
    assert_response :success
  end

  test "should update alert_setting" do
    patch alert_setting_url(@alert_setting), params: { alert_setting: { keyword_id: @alert_setting.keyword_id, notification_method: @alert_setting.notification_method, threshold: @alert_setting.threshold } }
    assert_redirected_to alert_setting_url(@alert_setting)
  end

  test "should destroy alert_setting" do
    assert_difference("AlertSetting.count", -1) do
      delete alert_setting_url(@alert_setting)
    end

    assert_redirected_to alert_settings_url
  end
end
