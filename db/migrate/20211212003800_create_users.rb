class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.boolean :admin, default: false, null: false
      t.string :password_digest, null: false
      t.string :image

      t.timestamps
      t.index :email, unique: true
    end
  end
end
