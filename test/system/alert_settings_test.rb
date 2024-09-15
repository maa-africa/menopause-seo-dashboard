require "application_system_test_case"

class AlertSettingsTest < ApplicationSystemTestCase
  setup do
    @alert_setting = alert_settings(:one)
  end

  test "visiting the index" do
    visit alert_settings_url
    assert_selector "h1", text: "Alert settings"
  end

  test "should create alert setting" do
    visit alert_settings_url
    click_on "New alert setting"

    fill_in "Keyword", with: @alert_setting.keyword_id
    fill_in "Notification method", with: @alert_setting.notification_method
    fill_in "Threshold", with: @alert_setting.threshold
    click_on "Create Alert setting"

    assert_text "Alert setting was successfully created"
    click_on "Back"
  end

  test "should update Alert setting" do
    visit alert_setting_url(@alert_setting)
    click_on "Edit this alert setting", match: :first

    fill_in "Keyword", with: @alert_setting.keyword_id
    fill_in "Notification method", with: @alert_setting.notification_method
    fill_in "Threshold", with: @alert_setting.threshold
    click_on "Update Alert setting"

    assert_text "Alert setting was successfully updated"
    click_on "Back"
  end

  test "should destroy Alert setting" do
    visit alert_setting_url(@alert_setting)
    click_on "Destroy this alert setting", match: :first

    assert_text "Alert setting was successfully destroyed"
  end
end
