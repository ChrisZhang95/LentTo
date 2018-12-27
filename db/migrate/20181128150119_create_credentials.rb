class CreateCredentials < ActiveRecord::Migration[5.2]
  def change
    create_table :credentials do |t|
      t.string :token
      t.boolean :expires
      t.integer :expires_at
      t.string :refresh_token
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
