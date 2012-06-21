class CreateTargets < ActiveRecord::Migration
  def change
    create_table :targets do |t|
      t.string :name
      t.string :query
      t.string :max_id_twitter

      t.timestamps
    end
  end
end
