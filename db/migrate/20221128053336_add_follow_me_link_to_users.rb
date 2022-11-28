class AddFollowMeLinkToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :follow_me_link, :string
  end
end
