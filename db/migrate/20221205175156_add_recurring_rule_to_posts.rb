class AddRecurringRuleToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :recurring, :boolean, default: false
    add_column :posts, :recurring_rule, :text

    execute "UPDATE posts SET recurring = false"
  end
end
