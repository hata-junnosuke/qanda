class ChangeUsersNameLimit < ActiveRecord::Migration[6.1]
  def up
    change_column :users, :name, :string, limit: 15
  end

  def down
    change_column :users, :name, :string
  end
end
