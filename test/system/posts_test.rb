require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  setup do
    @post = posts(:one)
  end

  test "visiting the index" do
    visit posts_url
    assert_selector "h1", text: "Posts"
  end

  test "creating a Post" do
    visit posts_url
    click_on "New Post"

    check "Approved" if @post.approved
    check "Archive" if @post.archive
    fill_in "Category", with: @post.category
    fill_in "En post", with: @post.en_post
    check "Featured" if @post.featured
    fill_in "Ko post", with: @post.ko_post
    fill_in "Priority", with: @post.priority
    fill_in "Tags", with: @post.tags
    click_on "Create Post"

    assert_text "Post was successfully created"
    click_on "Back"
  end

  test "updating a Post" do
    visit posts_url
    click_on "Edit", match: :first

    check "Approved" if @post.approved
    check "Archive" if @post.archive
    fill_in "Category", with: @post.category
    fill_in "En post", with: @post.en_post
    check "Featured" if @post.featured
    fill_in "Ko post", with: @post.ko_post
    fill_in "Priority", with: @post.priority
    fill_in "Tags", with: @post.tags
    click_on "Update Post"

    assert_text "Post was successfully updated"
    click_on "Back"
  end

  test "destroying a Post" do
    visit posts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Post was successfully destroyed"
  end
end
