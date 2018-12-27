require 'test_helper'

class UratingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "Cannot make user rating without user" do
      rating = Urating.new({commenter_id: 723067260, score: 5, comment: "This is test"})
      assert_not rating.save, "Should not be able to save rating without user_id"
  end
  test "Cannot make user rating without commenter" do
    rating = Urating.new({user_id: 110237153, score: 5, comment: "This is test"})
    assert_not rating.save, "Should not be able to save rating without commenter_id"
  end
  test "Cannot make user rating without score" do
    rating = Urating.new({user_id: 110237153, commenter_id: 723067260, comment: "This is test"})
    assert_not rating.save, "Should not be able to save rating without score"
  end
end
