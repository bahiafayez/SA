class CreateArticleKeywords < ActiveRecord::Migration
  def change
    create_table :article_keywords do |t|
      t.integer :keyword_id
      t.integer :article_id
      t.integer :score

      t.timestamps
    end
  end
end
