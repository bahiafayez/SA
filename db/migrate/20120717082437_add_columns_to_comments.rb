class AddColumnsToComments < ActiveRecord::Migration
  def change
    add_column :comments, :coloured_comment, :text

    add_column :comments, :polarity, :integer

  end
end
