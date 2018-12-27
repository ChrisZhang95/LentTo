class AddLocationToProfileAddAddressToItem < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :address, :string
    add_column :profiles, :location, :string
    add_column :profiles, :address, :string
  end
end
