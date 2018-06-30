class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|

      t.string :username, null: false
      t.string :email, null: false
      t.string :password, null: false
      t.boolean :is_admin , :default => false
      t.string  :last_page

      t.timestamps null: false

    end
  end
end