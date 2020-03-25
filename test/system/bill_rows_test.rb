require "application_system_test_case"

class BillRowsTest < ApplicationSystemTestCase
  setup do
    @bill_row = bill_rows(:one)
  end

  test "visiting the index" do
    visit bill_rows_url
    assert_selector "h1", text: "Bill Rows"
  end

  test "creating a Bill row" do
    visit bill_rows_url
    click_on "New Bill Row"

    fill_in "Amount", with: @bill_row.amount
    fill_in "Price", with: @bill_row.price
    fill_in "Product", with: @bill_row.product_id
    click_on "Create Bill row"

    assert_text "Bill row was successfully created"
    click_on "Back"
  end

  test "updating a Bill row" do
    visit bill_rows_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @bill_row.amount
    fill_in "Price", with: @bill_row.price
    fill_in "Product", with: @bill_row.product_id
    click_on "Update Bill row"

    assert_text "Bill row was successfully updated"
    click_on "Back"
  end

  test "destroying a Bill row" do
    visit bill_rows_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Bill row was successfully destroyed"
  end
end
