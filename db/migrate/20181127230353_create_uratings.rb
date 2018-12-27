class CreateUratings < ActiveRecord::Migration[5.2]
  def change
    create_table :uratings do |t|
      t.integer :score
      t.text :comment
      t.integer :commenter_id
      t.references :user, foreign_key: true
    
      t.timestamps
    end
  end
end
