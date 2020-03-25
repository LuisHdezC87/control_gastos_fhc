require "application_system_test_case"

class BillTypesTest < ApplicationSystemTestCase
  setup do
    @bill_type = bill_types(:one)
  end

  test "visiting the index" do
    visit bill_types_url
    assert_selector "h1", text: "Bill Types"
  end

  test "creating a Bill type" do
    visit bill_types_url
    click_on "New Bill Type"

    fill_in "Description", with: @bill_type.description
    fill_in "Name", with: @bill_type.name
    fill_in "Project", with: @bill_type.project_id
    click_on "Create Bill type"

    assert_text "Bill type was successfully created"
    click_on "Back"
  end

  test "updating a Bill type" do
    visit bill_types_url
    click_on "Edit", match: :first

    fill_in "Description", with: @bill_type.description
    fill_in "Name", with: @bill_type.name
    fill_in "Project", with: @bill_type.project_id
    click_on "Update Bill type"

    assert_text "Bill type was successfully updated"
    click_on "Back"
  end

  test "destroying a Bill type" do
    visit bill_types_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Bill type was successfully destroyed"
  end
end
