class AddAttrsToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :dollars, :float, default: 0
    add_column :posts, :hours, :float, default: 0
  end
end
