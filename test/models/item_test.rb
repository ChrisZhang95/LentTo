require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "Cannot create new item without name" do
    item = Item.new({description: "test", user_id: 0, category_id: 0, location: "location_test", address: "address_test", public: 'Yes'})
    assert_not item.save, "Should not create without name"
  end
  test "Cannot create new item without description" do
    item = Item.new({name: "test", user_id: 0, category_id: 0, location: "location_test", address: "address_test", public: 'Yes'})
    assert_not item.save, "Should not create without name"
  end
  test "Cannot create new item without user Id" do
    item = Item.new({name:"test", description: "test", category_id: 0, location: "location_test", address: "address_test", public: 'Yes'})
    assert_not item.save, "Should not create without user Id"
  end
  test "Cannot create new item without category Id" do
    item = Item.new({name:"test", description: "test", user_id: 0, location: "location_test", address: "address_test", public: 'Yes'})
    assert_not item.save, "Should not create without category Id"
  end
  test "Cannot create new item without location" do
    item = Item.new({name:"test", description: "test", user_id: 0, category_id: 0, address: "address_test", public: 'Yes'})
    assert_not item.save, "Should not create without location"
  end
  test "Cannot create new item without state" do
    item = Item.new({name:"test", description: "test", user_id: 0, category_id: 0, location: "location_test", address: "address_test"})
    assert_not item.save, "Should not create without state"
  end
  test "Cannot create new item with non-existent user_id" do
    item = Item.new({name:"test", description: "test", user_id: 1010101010101010, category_id: 723067260, location: "location_test", address: "address_test", public: 'Yes'})
    assert_not item.save, "Should not create with non-existent id"
  end
  test "Cannot create new item with non-existent category_id" do
    item = Item.new({name:"test", description: "test", user_id: 110237153, category_id: 1010101010101010, location: "location_test", address: "address_test", public: 'Yes'})
    assert_not item.save, "Should not create with non-existent id"
  end
  test "Should create with valid params" do
    @item = Item.new({name:"test", description: "test", user_id: 110237153, category_id: 723067260, location: "location_test", address: "address_test", public: 'Yes'})
    assert @item.save, @item.errors.full_messages
  end
end
