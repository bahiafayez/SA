class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :source_id
      t.string :id_str
      t.datetime :date
      t.string :url
      t.string :title
      t.text :body
      t.string :metadata
      t.integer :target_id

      t.timestamps
    end
  end
end
