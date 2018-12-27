class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name

      t.references :user, foreign_key: true
      t.references :category, foreign_key: true
      t.string :location

      t.timestamps
    end
  end
end

