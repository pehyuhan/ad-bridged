class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|

      t.string :company_name
      t.string :ad_type
      t.string :country_code
      t.string :number_of_enquiries
      t.string :image_url
      t.string :platform_type

      t.timestamps null: false
    end
  end
end
