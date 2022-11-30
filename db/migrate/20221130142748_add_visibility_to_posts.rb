class AddVisibilityToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :visibility, :string
    execute "UPDATE posts SET visibility = 'public'"
  end
end
