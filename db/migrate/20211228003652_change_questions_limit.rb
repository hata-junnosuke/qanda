class ChangeQuestionsLimit < ActiveRecord::Migration[6.1]
  def up
    change_column :questions, :title, :string, limit: 30
    change_column :questions, :body, :string, limit: 1000
  end

  def down
    change_column :questions, :title, :string
    change_column :questions, :body, :string
  end
end
