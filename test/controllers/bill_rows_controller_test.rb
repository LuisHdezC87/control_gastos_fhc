require 'test_helper'

class BillRowsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bill_row = bill_rows(:one)
  end

  test "should get index" do
    get bill_rows_url
    assert_response :success
  end

  test "should get new" do
    get new_bill_row_url
    assert_response :success
  end

  test "should create bill_row" do
    assert_difference('BillRow.count') do
      post bill_rows_url, params: { bill_row: { amount: @bill_row.amount, price: @bill_row.price, product_id: @bill_row.product_id } }
    end

    assert_redirected_to bill_row_url(BillRow.last)
  end

  test "should show bill_row" do
    get bill_row_url(@bill_row)
    assert_response :success
  end

  test "should get edit" do
    get edit_bill_row_url(@bill_row)
    assert_response :success
  end

  test "should update bill_row" do
    patch bill_row_url(@bill_row), params: { bill_row: { amount: @bill_row.amount, price: @bill_row.price, product_id: @bill_row.product_id } }
    assert_redirected_to bill_row_url(@bill_row)
  end

  test "should destroy bill_row" do
    assert_difference('BillRow.count', -1) do
      delete bill_row_url(@bill_row)
    end

    assert_redirected_to bill_rows_url
  end
end
