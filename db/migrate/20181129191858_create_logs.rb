class CreateLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :logs do |t|
      t.string :title
      t.string :details
      t.boolean :seen, :default => false
      t.integer :affected_user
      t.integer :sendng_user
      t.timestamps
    end
  end
end
