require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "Should not be able to submit Profile without a User" do
    profile = Profile.new({first_name: "Tester", last_name: "Mc Tester Face", location: "Test_location", address: "Test Address"})
    asset_not profile.save, "Should not be able to create profile record without attached user"
  end
end
