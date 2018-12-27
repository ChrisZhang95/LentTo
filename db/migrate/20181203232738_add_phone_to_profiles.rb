class AddPhoneToProfiles < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :phone, :string
  end
end
