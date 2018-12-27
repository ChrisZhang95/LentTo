require 'test_helper'

class LogTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "Should be able to add a complete log" do
    log = Log.new({title: "test", details:"test", seen: "Yes", affected_user: 1, sendng_user: 2})
    assert log.save, log.errors.full_messages
  end
  test "Should not be able to add a log with no title" do
    log = Log.new({details:"test", seen: "Yes", affected_user: 1, sendng_user: 2})
    assert_not log.save, "Should not be able to add no title log"
  end
  test "Should not be able to add a no seen state log" do
    log = Log.new({title: "test", details:"test", affected_user: 1, sendng_user: 2})
    assert_not log.save, "Should not be able to add no title log"
  end
  test "Should not be able to add log that affects no one" do
    log = Log.new({title: "test", details:"test", seen: "Yes", sendng_user: 2})
    assert_not log.save, "Should not be able to add no affected user log"
  end
end
