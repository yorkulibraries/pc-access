require 'test_helper'

class SoftwarePackagesControllerTest < ActionController::TestCase
  setup do
    @software_package = software_packages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:software_packages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create software_package" do
    assert_difference('SoftwarePackage.count') do
      post :create, software_package: { image_id: @software_package.image_id, name: @software_package.name, note: @software_package.note, version: @software_package.version }
    end

    assert_redirected_to software_package_path(assigns(:software_package))
  end

  test "should show software_package" do
    get :show, id: @software_package
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @software_package
    assert_response :success
  end

  test "should update software_package" do
    patch :update, id: @software_package, software_package: { image_id: @software_package.image_id, name: @software_package.name, note: @software_package.note, version: @software_package.version }
    assert_redirected_to software_package_path(assigns(:software_package))
  end

  test "should destroy software_package" do
    assert_difference('SoftwarePackage.count', -1) do
      delete :destroy, id: @software_package
    end

    assert_redirected_to software_packages_path
  end
end
