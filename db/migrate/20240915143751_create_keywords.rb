class CreateKeywords < ActiveRecord::Migration[7.2]
  def change
    create_table :keywords do |t|
      t.string :name
      t.string :target_url
      t.string :search_engine

      t.timestamps
    end
  end
end
