class CreateEnquiries < ActiveRecord::Migration
  def change
    create_table :enquiries do |t|
      
      t.belongs_to :post, index: true

      t.timestamps null: false
    end
end
