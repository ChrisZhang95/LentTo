class AddPublicToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :public, :boolean
  end
end
