require 'test_helper'

class BillTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bill_type = bill_types(:one)
  end

  test "should get index" do
    get bill_types_url
    assert_response :success
  end

  test "should get new" do
    get new_bill_type_url
    assert_response :success
  end

  test "should create bill_type" do
    assert_difference('BillType.count') do
      post bill_types_url, params: { bill_type: { description: @bill_type.description, name: @bill_type.name, project_id: @bill_type.project_id } }
    end

    assert_redirected_to bill_type_url(BillType.last)
  end

  test "should show bill_type" do
    get bill_type_url(@bill_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_bill_type_url(@bill_type)
    assert_response :success
  end

  test "should update bill_type" do
    patch bill_type_url(@bill_type), params: { bill_type: { description: @bill_type.description, name: @bill_type.name, project_id: @bill_type.project_id } }
    assert_redirected_to bill_type_url(@bill_type)
  end

  test "should destroy bill_type" do
    assert_difference('BillType.count', -1) do
      delete bill_type_url(@bill_type)
    end

    assert_redirected_to bill_types_url
  end
end
