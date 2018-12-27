require 'test_helper'

class RatingControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get rating_index_url
    assert_response :success
  end

  test "should get show" do
    get rating_show_url
    assert_response :success
  end

  test "should get new" do
    get rating_new_url
    assert_response :success
  end

  test "should get edit" do
    get rating_edit_url
    assert_response :success
  end

end
