require 'test_helper'

class ImagesControllerTest < ActionController::TestCase

  context "CRUD Controller Image Tests" do

    setup do
      @image = create(:image)

      #@user = create(:user, admin: true, role: User::MANAGER_ROLE, location: @mylocation)
      #log_user_in(@user)

    end

    should "list all images" do
       create_list(:image, 10)

       get :index
       assert_template :index
       images  = assigns(:images)
       assert_equal 11, images.size, "10 images + 1 from setup"
     end

     should "show new image form" do
       get :new
       assert_response :success
       assert_template :new
     end

     should "create a new image" do
       assert_difference('Image.count') do
         post :create, image: attributes_for(:image)
         image = assigns(:image)
         assert_equal 0, image.errors.size, "Should be no errors"
         assert_redirected_to images_path
       end

     end

     should "show image details" do
       get :show, id: @image
       assert_response :success
       assert_template :show
     end

     should "show get edit form" do
       get :edit, id: @image
       assert_response :success
     end

     should "update an existing location" do
       old_image_name = @image.name

       patch :update, id: @image.id, image: { name: "WinXP" }
       image = assigns(:image)
       assert_equal 0, image.errors.size, "image name did not update"
       assert_response :redirect
       assert_redirected_to images_path

       assert_not_equal old_image_name, image.name, "Old image name is not there"
       assert_equal "WinXP", image.name, "Image name was updated"

     end

     should  "delete image" do
       i = create(:image)
       assert_no_difference('Image.unscoped.count', "image was not removed, but deleted flag was set") do
         delete :destroy, id: i.id
       end

       i.reload
       assert i.deleted?, "Deleted flag was set"

     end

  end

end
