class AddOccupationToProfiles < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :occupation, :string
    add_column :profiles, :facebook, :string
    add_column :profiles, :linkedin, :string
  end
end
