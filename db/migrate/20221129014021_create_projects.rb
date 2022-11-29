class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :tagline
      t.string :description
      t.string :external_url

      t.timestamps
    end
  end
end
