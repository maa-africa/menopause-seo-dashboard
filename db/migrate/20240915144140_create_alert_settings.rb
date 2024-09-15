class CreateAlertSettings < ActiveRecord::Migration[7.2]
  def change
    create_table :alert_settings do |t|
      t.integer :keyword_id
      t.integer :threshold
      t.string :notification_method

      t.timestamps
    end
  end
end
