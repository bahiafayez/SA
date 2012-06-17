class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :article_id
      t.text :comment

      t.timestamps
    end
  end
end
