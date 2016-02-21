class AddAFewForUsersTable < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :short_bio, :text
  end
end
