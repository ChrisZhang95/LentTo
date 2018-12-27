class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|

      t.references :item, foreign_key: true
      t.references :user, foreign_key: true
      t.datetime :start_date
      t.datetime :end_date
      t.integer   :status

      t.timestamps
    end
  end
end
