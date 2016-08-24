class AddDescriptionsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :descriptions, :text
  end
end
