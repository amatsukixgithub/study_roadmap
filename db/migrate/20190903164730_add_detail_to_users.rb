class AddDetailToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string
    add_column :users, :comment, :string
    add_column :users, :icon_pass, :string
    add_column :users, :web_page, :string
  end
end
