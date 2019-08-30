class ChangeUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :user_name
    add_column :users, :username, :string, null: false, unique: true
  end
end
