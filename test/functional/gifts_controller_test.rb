require 'test_helper'

class GiftsControllerTest < ActionController::TestCase
  setup do
    @gift = FactoryGirl.create(:gift)
    @controller.expects(:authenticate_user!)
    current_user = FactoryGirl.build(:user)
    @controller.stubs(:current_user).returns(current_user)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gifts)
  end

  test "should get new" do
    xhr :get, :new
    assert_response :success
  end

  test "should create gift" do
    assert_difference('Gift.count') do
      xhr :post, :create, gift: { description: @gift.description, location: @gift.location, title: @gift.title, value: @gift.value }
    end
    assert_response :success
  end

  test "should show gift" do
    xhr :get, :show, id: @gift
    assert_response :success
    assert_equal @gift, assigns(:gift)
  end

  test "should get edit" do
    xhr :get, :edit, id: @gift
    assert_response :success
    assert_equal @gift, assigns(:gift)
  end

  test "should update gift" do
    xhr :put, :update, id: @gift, gift: { description: @gift.description, location: @gift.location, title: @gift.title, value: @gift.value }
    assert_response :success
    assert_not_nil assigns(:gift)
  end

  test "should destroy gift" do
    assert_difference('Gift.count', -1) do
      xhr :delete, :destroy, id: @gift
    end
    assert_response :success
  end
end
