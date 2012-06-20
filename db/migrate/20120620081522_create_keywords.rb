class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.string :name
      t.string :max_id_twitter

      t.timestamps
    end
  end
end
