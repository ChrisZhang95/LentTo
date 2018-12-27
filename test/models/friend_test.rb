require 'test_helper'

class FriendTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "Should not save without master user" do
    friend = Friend.new
    assert_not friend.save, "saved without master user"
  end
end
