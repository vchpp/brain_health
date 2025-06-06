require "application_system_test_case"

class BoardsTest < ApplicationSystemTestCase
  setup do
    @board = boards(:one)
  end

  test "visiting the index" do
    visit boards_url
    assert_selector "h1", text: "Boards"
  end

  test "creating a Board" do
    visit boards_url
    click_on "New Board"

    check "Approved" if @board.approved
    check "Archive" if @board.archive
    fill_in "Category", with: @board.category
    fill_in "En post", with: @board.en_post
    check "Featured" if @board.featured
    fill_in "Ko post", with: @board.ko_post
    fill_in "Priority", with: @board.priority
    fill_in "Tags", with: @board.tags
    click_on "Create Board"

    assert_text "Board was successfully created"
    click_on "Back"
  end

  test "updating a Board" do
    visit boards_url
    click_on "Edit", match: :first

    check "Approved" if @board.approved
    check "Archive" if @board.archive
    fill_in "Category", with: @board.category
    fill_in "En post", with: @board.en_post
    check "Featured" if @board.featured
    fill_in "Ko post", with: @board.ko_post
    fill_in "Priority", with: @board.priority
    fill_in "Tags", with: @board.tags
    click_on "Update Board"

    assert_text "Board was successfully updated"
    click_on "Back"
  end

  test "destroying a Board" do
    visit boards_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Board was successfully destroyed"
  end
end
