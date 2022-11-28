class AddTimelineFeatureToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :featured, :boolean, default: false
  end
end
