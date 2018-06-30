require 'sinatra/activerecord'

class CreatePages < ActiveRecord::Migration[5.2]
  def change
    create_table :pages do |t|
      t.string :link,  null: false

      t.references :category, foreign_key: true
    end
  end
end
