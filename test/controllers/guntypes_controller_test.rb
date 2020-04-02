require 'test_helper'

class GuntypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @guntype = guntypes(:one)
  end

  test "should get index" do
    get guntypes_url
    assert_response :success
  end

  test "should get new" do
    get new_guntype_url
    assert_response :success
  end

  test "should create guntype" do
    assert_difference('Guntype.count') do
      post guntypes_url, params: { guntype: { gunshottype: @guntype.gunshottype } }
    end

    assert_redirected_to guntype_url(Guntype.last)
  end

  test "should show guntype" do
    get guntype_url(@guntype)
    assert_response :success
  end

  test "should get edit" do
    get edit_guntype_url(@guntype)
    assert_response :success
  end

  test "should update guntype" do
    patch guntype_url(@guntype), params: { guntype: { gunshottype: @guntype.gunshottype } }
    assert_redirected_to guntype_url(@guntype)
  end

  test "should destroy guntype" do
    assert_difference('Guntype.count', -1) do
      delete guntype_url(@guntype)
    end

    assert_redirected_to guntypes_url
  end
end
