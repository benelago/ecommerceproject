require "application_system_test_case"

class GuntypesTest < ApplicationSystemTestCase
  setup do
    @guntype = guntypes(:one)
  end

  test "visiting the index" do
    visit guntypes_url
    assert_selector "h1", text: "Guntypes"
  end

  test "creating a Guntype" do
    visit guntypes_url
    click_on "New Guntype"

    fill_in "Gunshottype", with: @guntype.gunshottype
    click_on "Create Guntype"

    assert_text "Guntype was successfully created"
    click_on "Back"
  end

  test "updating a Guntype" do
    visit guntypes_url
    click_on "Edit", match: :first

    fill_in "Gunshottype", with: @guntype.gunshottype
    click_on "Update Guntype"

    assert_text "Guntype was successfully updated"
    click_on "Back"
  end

  test "destroying a Guntype" do
    visit guntypes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Guntype was successfully destroyed"
  end
end
