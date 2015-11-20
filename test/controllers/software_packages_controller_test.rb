require 'test_helper'

class SoftwarePackagesControllerTest < ActionController::TestCase
  setup do
    @image = create(:image)

    #@user = create(:user, admin: true, role: User::MANAGER_ROLE, location: @mylocation)
    #log_user_in(@user)

  end


   should "create a new software_package" do
     assert_difference('SoftwarePackage.count') do
       post :create, software_package: attributes_for(:software_package), image_id: @image.id
       software_package = assigns(:software_package)
       assert_equal 0, software_package.errors.size, "Should be no errors #{software_package.errors.messages}"
       assert_redirected_to @image
     end

   end

   should "show software_package details" do
     software_package = create(:software_package, image: @image)

     get :show, id: software_package, image_id: @image.id
     assert_response :success
     assert_template :show
   end

   should "show get edit form" do
     software_package = create(:software_package, image: @image)

     get :edit, id: software_package, image_id: @image.id
     assert_response :success
   end

   should "update an existing software_package" do
     software_package = create(:software_package, image: @image)

     old_software_package_name = software_package.name

     patch :update, id: software_package.id, software_package: { name: "word2" }, image_id: @image.id
     software_package = assigns(:software_package)
     assert_equal 0, software_package.errors.size, "Area name should update"
     assert_response :redirect
     assert_redirected_to @image

     assert_not_equal old_software_package_name, software_package.name, "Old software_package name is not there"
     assert_equal "word2", software_package.name, "software_package Name was updated"

   end

   should  "delete software_package" do
     software_package = create(:software_package, image: @image)

     assert_difference('SoftwarePackage.unscoped.count', -1) do
       post :destroy, id: software_package.id, image_id: @image.id

       assert_response :redirect
       assert_redirected_to @image
     end

   end


end
