require 'test_helper'

class AnnouncementTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "Should not be able to create an announcement without category" do 
    announcement = Announcement.new({title: "test", caption: "test", description: "This is test"})
    assert_not  announcement.save, "Should not be able to save announcement without tatle without item"
  end

  test "Should not be able to create an announcement without title" do 
    announcement = Announcement.new({caption: "test", description: "This is test",category: 1090909})
    assert_not  announcement.save, "Should not be able to save announcement without tatle without item"
  end
 
end
