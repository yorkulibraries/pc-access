require 'test_helper'

class AreasControllerTest < ActionController::TestCase
  context "CRUD Controller area Tests" do

    setup do
      @location = create(:location)

      #@user = create(:user, admin: true, role: User::MANAGER_ROLE, location: @mylocation)
      #log_user_in(@user)

    end

    should "list all areas" do
       create_list(:area, 10, location: @location)

       get :index, location_id: @location.id
       assert_template :index
       areas  = assigns(:areas)
       assert_equal 10, areas.size, "10 areas"
     end

     should "show new area form" do

       get :new, location_id: @location.id
       assert_response :success
       assert_template :new
     end

     should "create a new area" do
       assert_difference('Area.count') do
         post :create, area: attributes_for(:area, floor_id: @location.floors.first.id), location_id: @location.id
         area = assigns(:area)
         assert_equal 0, area.errors.size, "Should be no errors #{area.errors.messages}"
         assert_redirected_to location_areas_path(@location)
       end

     end

     should "show Area details" do
       area = create(:area, location: @location)

       get :show, id: area, location_id: @location.id
       assert_response :success
       assert_template :show
     end

     should "show get edit form" do
       area = create(:area, location: @location)

       get :edit, id: area, location_id: @location.id
       assert_response :success
     end

     should "update an existing Area" do
       area = create(:area, location: @location)

       old_area_name = area.name

       patch :update, id: area.id, area: { name: "2rd area" }, location_id: @location.id
       area = assigns(:area)
       assert_equal 0, area.errors.size, "Area name should update"
       assert_response :redirect
       assert_redirected_to location_areas_path(@location)

       assert_not_equal old_area_name, area.name, "Old Area name is not there"
       assert_equal "2rd area", area.name, "Area Name was updated"

     end

     should  "delete Area" do
       f = create(:area, location: @location)

       assert_no_difference('Area.unscoped.count', "Area was not removed, but flag set") do
         post :destroy, id: f.id, location_id: @location.id
         area = assigns(:area)
         assert area.deleted?, "Deleted flag was not set"

         assert_response :redirect
         assert_redirected_to location_areas_path(@location)
       end

     end

  end
end
