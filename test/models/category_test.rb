require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "Should not save without name" do
    category = Category.new
    assert_not category.save, "created category without name"
  end
end
