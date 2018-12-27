require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  include Devise::Test::IntegrationHelpers

  #def setup
  #  sign_in FactoryBot.create(:user)
  #end

  #test "Can see landing page" do
  #  get "/landing"
  #  assert_equal 200, status
  #end

  test "Can login" do
    visit "/"
    #follow_redirect!
    save_and_open_page
    assert_selector "div", text: "Welcome"
  end
  
   test "can create a category" do
    get "/categories/new"
    assert_response :success
   
    post "/categories",
      params: { category: { name: "can create" } }
    #assert_response :redirect
    #follow_redirect!
    assert_response :success
    #assert_select "p", "Title:\n  can create"
  end
end
