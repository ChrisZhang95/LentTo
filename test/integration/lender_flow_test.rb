require 'test_helper'

class LenderFlowTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  test "Basic functionalities" do

# user ben goes to landing page
  get "/landing"              
  assert_response :success

 # user ben signed in
    get "/users/sign_in"              
    assert_response :success

    post "/users/sign_in", params: {user: {
      email:    users(:ben).email,
      password: "123456"
    }}
    assert_response :redirect

 # user ben edit profile (profile show/edit/update)
 get "/profile"
 assert_response :success

 #patch "/profile",
 #params: { profile: { user_id: 110237153, first_name: "Tester", last_name: "Mc Tester Face", user: "ben", location: "Test_location", address: "Test Address" } }
 #assert_response :success


    
  # user ben add item A   (item new/create)
    get "/items/new"
    assert_response :success

    post "/items",
      params: { item: {name:"test", description: "test", user_id: 110237153, category_id: 723067260, location: "location_test", address: "address_test", public: 'Yes' } }
      assert_response :redirect
      follow_redirect!
      assert_response :success

 # user ben edit item "Projector" (item edit/update)
    get "/items/18/edit"
    assert_response :success

    patch "/items/18",
    params: { item: { name:"test-edited", description: "edit", user_id: 110237153, category_id: 723067260, location: "location_test", address: "address_test", public: 'Yes' } }
    assert_response :redirect
    follow_redirect!
    assert_response :success

     
  # user ben show/delete item "Projector"(item show/destroy)
    get "/items/18"
    assert_response :success

    delete "/items/18"
    assert_response :redirect
    follow_redirect!
    assert_response :success



# user ben goes to market place  (access marketplace index/show)
      get "/marketplaces"
      assert_response :success
     
   
# user ben create a category  (category new/create)
       get "/categories/new"
       assert_response :success
   
       post "/categories",
       params: { category: { name: "category" } }
       assert_response :success

  # user ben edit a category  (category edit/update)
  get "/categories/169552531/edit"
  assert_response :success

  patch "/categories/169552531",
  params: { category: { name: "edited-category" } }
  assert_response :redirect
   follow_redirect!
   assert_response :success


   # user ben show/delete category(item show/destroy)
   get "/categories/169552531"
   assert_response :success

   delete "/categories/169552531"
   assert_response :redirect
   follow_redirect!
   assert_response :success

   
 # user ben create a friend  (friend new/create)
 get "/friends/new"
 assert_response :success

 post "/friends",
 params: { friend: {user_id:110237153, first_name: "create-friend",last_name: "create-friend",target_id: 839977508 } }
 assert_response :redirect
 follow_redirect!
 assert_response :success 




 # user ben create a announcement  (announcement new/create)
 get "/announcements/new"
 assert_response :success

 post "/announcements",
 params: {announcement: { title: "test", caption: "test", description: "This is test",category: 1090909 } }
 assert_response :redirect
 follow_redirect!
 assert_response :success 

# user ben edit a announcement  (announcement edit/update)
get "/announcements/298486374/edit"
assert_response :success

patch "/announcements/298486374",
params: { announcement: { title: "test", caption: "test", description: "This is test",category: 1090909 } }
assert_response :redirect
follow_redirect!
assert_response :success


# user ben show/delete announcement(announcement show/destroy)
get "/announcements/298486374"
assert_response :success

delete "/announcements/298486374"
assert_response :redirect
follow_redirect!
assert_response :success



 # user ben create a rating  (rating new/create)
get "/items/12/ratings/new"
assert_response :success

post "/items/12/ratings",
params: {rating: {user_id: 110237153, item_id: 723067260, score: 5, comment: "This is test" } }
assert_response :redirect
follow_redirect!
assert_response :success


# user ben edit a rating  (rating edit/update)
#get "/items/11/ratings/298486374/edit"
#assert_response :success

#patch "/items/298486374/ratings/298486374",
#params: { rating: { name: "edit rating" } }
#assert_response :success


# user ben show/delete rating(rating show/destroy)
#get "/items/298486374/ratings/298486374"
#assert_response :success

#delete "/items/298486374/ratings/298486374"
#assert_response :redirect
#follow_redirect!
#assert_response :success

   

# user ben signed out
delete "/users/sign_out"              
assert_response :redirect

end
end
   
  
   
 
  

 




