class DropUnusedAttrs < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :stripe_customer_id
    remove_column :users, :stripe_subscription_id
  end
end
