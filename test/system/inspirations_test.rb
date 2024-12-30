require "application_system_test_case"

class InspirationsTest < ApplicationSystemTestCase
  setup do
    @inspiration = inspirations(:one)
  end

  test "visiting the index" do
    visit inspirations_url
    assert_selector "h1", text: "inspirations"
  end

  test "creating a inspiration" do
    visit inspirations_url
    click_on "New inspiration"

    check "Archive" if @inspiration.archive
    fill_in "Category", with: @inspiration.category
    fill_in "En inspiration", with: @inspiration.en_inspiration
    check "Featured" if @inspiration.featured
    fill_in "Hm inspiration", with: @inspiration.hm_inspiration
    fill_in "Ko inspiration", with: @inspiration.ko_inspiration
    fill_in "Priority", with: @inspiration.priority
    fill_in "Tags", with: @inspiration.tags
    fill_in "Vi inspiration", with: @inspiration.vi_inspiration
    fill_in "Zh cn inspiration", with: @inspiration.zh_cn_inspiration
    fill_in "Zh tw inspiration", with: @inspiration.zh_tw_inspiration
    click_on "Create inspiration"

    assert_text "Inspiration was successfully created"
    click_on "Back"
  end

  test "updating a inspiration" do
    visit inspirations_url
    click_on "Edit", match: :first

    check "Archive" if @inspiration.archive
    fill_in "Category", with: @inspiration.category
    fill_in "En inspiration", with: @inspiration.en_inspiration
    check "Featured" if @inspiration.featured
    fill_in "Hm inspiration", with: @inspiration.hm_inspiration
    fill_in "Ko inspiration", with: @inspiration.ko_inspiration
    fill_in "Priority", with: @inspiration.priority
    fill_in "Tags", with: @inspiration.tags
    fill_in "Vi inspiration", with: @inspiration.vi_inspiration
    fill_in "Zh cn inspiration", with: @inspiration.zh_cn_inspiration
    fill_in "Zh tw inspiration", with: @inspiration.zh_tw_inspiration
    click_on "Update inspiration"

    assert_text "Inspiration was successfully updated"
    click_on "Back"
  end

  test "destroying a inspiration" do
    visit inspirations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Inspiration was successfully destroyed"
  end
end
