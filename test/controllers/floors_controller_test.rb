require 'test_helper'

class FloorsControllerTest < ActionController::TestCase
  context "CRUD Controller Floor Tests" do

    setup do
      @location = create(:location)
      @location.floors.first.destroy # destroy the initial one, we don't need it to mess up our counts


      #@user = create(:user, admin: true, role: User::MANAGER_ROLE, location: @mylocation)
      #log_user_in(@user)

    end

    should "list all floors" do
       create_list(:floor, 10, location: @location)

       get :index, location_id: @location.id
       assert_template :index
       floors  = assigns(:floors)
       assert_equal 10, floors.size, "10 floors"
     end

     should "show new floor form" do

       get :new, location_id: @location.id
       assert_response :success
       assert_template :new
     end

     should "create a new floor" do
       assert_difference('Floor.count') do
         post :create, floor: attributes_for(:floor), location_id: @location.id
         floor = assigns(:floor)
         assert_equal 0, floor.errors.size, "Should be no errors"
         assert_redirected_to location_floors_path(@location)
       end

     end

     should "show floor details" do
       floor = create(:floor, location: @location)

       get :show, id: floor, location_id: @location.id
       assert_response :success
       assert_template :show
     end

     should "show get edit form" do
       floor = create(:floor, location: @location)

       get :edit, id: floor, location_id: @location.id
       assert_response :success
     end

     should "update an existing floor" do
       floor = create(:floor, location: @location)

       old_floor_name = floor.name

       patch :update, id: floor.id, floor: { name: "2rd floor" }, location_id: @location.id
       floor = assigns(:floor)
       assert_equal 0, floor.errors.size, "Floor name should update"
       assert_response :redirect
       assert_redirected_to location_floors_path(@location)

       assert_not_equal old_floor_name, floor.name, "Old floor name is not there"
       assert_equal "2rd floor", floor.name, "Floor Name was updated"

     end

     should  "delete floor" do
       f = create(:floor, location: @location)

       assert_no_difference('Floor.unscoped.count', "Floor was not removed, but flag set") do
         post :destroy, id: f.id, location_id: @location.id
         floor = assigns(:floor)
         assert floor.deleted?, "Deleted flag was not set"

         assert_response :redirect
         assert_redirected_to location_floors_path(@location)
       end

     end

  end
end
