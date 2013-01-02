require 'test_helper'

class DropboxImagesControllerTest < ActionController::TestCase
  setup do
    @dropbox_image = FactoryGirl.create(:dropbox_image)
    @controller.expects(:authenticate_user!)
    current_user = FactoryGirl.build(:user)
    @controller.stubs(:current_user).returns(current_user)
  end

  test "should get index" do
    get :index
    assert_not_nil assigns(:dropbox_images)
  end

  test "should destroy dropbox_image" do
    assert_difference('DropboxImage.count', -1) do
      delete :destroy, id: @dropbox_image
    end

    assert_response :redirect
    assert_redirected_to dropbox_images_path
  end

  test "should list images id for thumbnails" do
    xhr :get, :thumbnails
    assert_response :success
    assert_equal [@dropbox_image.id], assigns(:image_ids)
  end

end
