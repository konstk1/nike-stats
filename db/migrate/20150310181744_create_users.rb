class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nike_username
      t.string :nike_access_token
      t.datetime :token_expiration_time

      t.timestamps null: false
    end
  end
end
