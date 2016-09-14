class ChangeNumberOfEnquiriesTypeInPost < ActiveRecord::Migration
  def change
    remove_column :posts, :number_of_enquiries
    add_column :posts, :number_of_enquiries, :integer, default: 0
  end
end
