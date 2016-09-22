class CreateFilterables < ActiveRecord::Migration
  def change
    create_table :filterables do |t|

      t.timestamps null: false
    end
  end
end
