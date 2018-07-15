require 'sinatra/activerecord'

# CreatePages migration
class CreatePages < ActiveRecord::Migration[5.2]
  def change
    create_table :pages do |t|
      t.string :name, null: false
      t.text :description
      t.string :url, null: false
      t.string :urlToImage
      
      t.timestamps
      t.references :user, foreign_key: true
    end
  end
end
