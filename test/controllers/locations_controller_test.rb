require 'test_helper'

class LocationsControllerTest < ActionController::TestCase
  context "CRUD Controller Location Tests" do

    setup do
      @location = create(:location)

      #@user = create(:user, admin: true, role: User::MANAGER_ROLE, location: @mylocation)
      #log_user_in(@user)

    end

    should "list all locations" do
       create_list(:location, 10)

       get :index
       assert_template :index
       locations  = assigns(:locations)
       assert_equal 11, locations.size, "10 Locations + 1 from setup"
     end

     should "show new location form" do
       get :new
       assert_response :success
       assert_template :new
     end

     should "create a new location" do
       assert_difference('Location.count') do
         post :create, location: attributes_for(:location)
         location = assigns(:location)
         assert_equal 0, location.errors.size, "Should be no errors"
         assert_redirected_to locations_path
       end

     end

     should "show location details" do
       get :show, id: @location
       assert_response :success
       assert_template :show
     end

     should "show get edit form" do
       get :edit, id: @location
       assert_response :success
     end

     should "update an existing location" do
       old_location_name = @location.name

       patch :update, id: @location.id, location: { name: "Scott Library" }
       location = assigns(:location)
       assert_equal 0, location.errors.size, "Location name did not update"
       assert_response :redirect
       assert_redirected_to locations_path

       assert_not_equal old_location_name, location.name, "Old location name is not there"
       assert_equal "Scott Library", location.name, "Location Name was updated"

     end

     should  "delete location" do
       loc = create(:location)
       assert_difference('Location.count', -1, "Location was deleted") do
         delete :destroy, id: loc.id
       end


     end

  end
end
