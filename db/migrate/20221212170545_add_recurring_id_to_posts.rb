class AddRecurringIdToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :recurring_id, :bigint
  end
end
