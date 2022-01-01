class ChangeAnswersLimit < ActiveRecord::Migration[6.1]
  def up
    change_column :answers, :body, :string, limit: 1000
  end

  def down
    change_column :answers, :body, :string
  end
end
