class AddColumnsToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :coloured_text, :text
    add_column :articles, :polarity, :integer
  end
end
