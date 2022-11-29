class AddMetaDescriptionToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :meta_description, :string
  end
end
