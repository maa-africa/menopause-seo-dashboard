class CreateSearches < ActiveRecord::Migration[7.2]
  def change
    create_table :searches do |t|
      t.string :query
      t.json :results
      t.json :ranking

      t.timestamps
    end
  end
end
