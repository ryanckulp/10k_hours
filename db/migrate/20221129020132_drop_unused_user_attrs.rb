class DropUnusedUserAttrs < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :paying_customer
    remove_column :users, :project_name
    remove_column :users, :project_description
    remove_column :users, :follow_me_link
  end
end
