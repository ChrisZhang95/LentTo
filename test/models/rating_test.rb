require 'test_helper'

class RatingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "Should not be able to create a rating without an item" do 
    rating = Rating.new({user_id: 110237153, score: 5, comment: "This is test"})
    assert_not rating.save, "Should not be able to save rating without item"
  end
  test "Should not be able to create a rating without an user" do 
    rating = Rating.new({item_id: 723067260, score: 5, comment: "This is test"})
    assert_not rating.save, "Should not be able to save rating without user"
  end
  test "Should not be able to create a rating without a score" do 
    rating = Rating.new({user_id: 110237153, item_id: 723067260, comment: "This is test"})
    assert_not rating.save, "Should not be able to save rating without score"
  end
end
