class AddAttrsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :project_name, :string
    add_column :users, :project_description, :string
    add_column :users, :bio, :string
  end
end
