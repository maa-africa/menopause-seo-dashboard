class AddKeywordToKeywords < ActiveRecord::Migration[7.2]
  def change
    add_column :keywords, :keyword, :string
  end
end
