require "application_system_test_case"

class AdditionalsTest < ApplicationSystemTestCase
  setup do
    @additional = additionals(:one)
  end

  test "visiting the index" do
    visit additionals_url
    assert_selector "h1", text: "Additionals"
  end

  test "creating a Additional" do
    visit additionals_url
    click_on "New Additional"

    fill_in "En content", with: @additional.en_content
    fill_in "En additional link", with: @additional.en_external_link
    fill_in "En notes", with: @additional.en_notes
    fill_in "En source", with: @additional.en_source
    fill_in "En title", with: @additional.en_title
    fill_in "Hm content", with: @additional.hm_content
    fill_in "Hm additional link", with: @additional.hm_external_link
    fill_in "Hm notes", with: @additional.hm_notes
    fill_in "Hm source", with: @additional.hm_source
    fill_in "Hm title", with: @additional.hm_title
    fill_in "Languages", with: @additional.languages
    fill_in "Last version date", with: @additional.last_version_date
    fill_in "Vi content", with: @additional.vi_content
    fill_in "Vi additional link", with: @additional.vi_external_link
    fill_in "Vi notes", with: @additional.vi_notes
    fill_in "Vi source", with: @additional.vi_source
    fill_in "Vi title", with: @additional.vi_title
    fill_in "Zh cn", with: @additional.zh_cn
    fill_in "Zh cn content", with: @additional.zh_cn_content
    fill_in "Zh cn additional link", with: @additional.zh_cn_external_link
    fill_in "Zh cn notes", with: @additional.zh_cn_notes
    fill_in "Zh cn title", with: @additional.zh_cn_title
    fill_in "Zh tw content", with: @additional.zh_tw_content
    fill_in "Zh tw additional link", with: @additional.zh_tw_external_link
    fill_in "Zh tw notes", with: @additional.zh_tw_notes
    fill_in "Zh tw source", with: @additional.zh_tw_source
    fill_in "Zh tw title", with: @additional.zh_tw_title
    click_on "Create Additional"

    assert_text "Additional was successfully created"
    click_on "Back"
  end

  test "updating a Additional" do
    visit additionals_url
    click_on "Edit", match: :first

    fill_in "En content", with: @additional.en_content
    fill_in "En additional link", with: @additional.en_external_link
    fill_in "En notes", with: @additional.en_notes
    fill_in "En source", with: @additional.en_source
    fill_in "En title", with: @additional.en_title
    fill_in "Hm content", with: @additional.hm_content
    fill_in "Hm additional link", with: @additional.hm_external_link
    fill_in "Hm notes", with: @additional.hm_notes
    fill_in "Hm source", with: @additional.hm_source
    fill_in "Hm title", with: @additional.hm_title
    fill_in "Languages", with: @additional.languages
    fill_in "Last version date", with: @additional.last_version_date
    fill_in "Vi content", with: @additional.vi_content
    fill_in "Vi additional link", with: @additional.vi_external_link
    fill_in "Vi notes", with: @additional.vi_notes
    fill_in "Vi source", with: @additional.vi_source
    fill_in "Vi title", with: @additional.vi_title
    fill_in "Zh cn", with: @additional.zh_cn
    fill_in "Zh cn content", with: @additional.zh_cn_content
    fill_in "Zh cn additional link", with: @additional.zh_cn_external_link
    fill_in "Zh cn notes", with: @additional.zh_cn_notes
    fill_in "Zh cn title", with: @additional.zh_cn_title
    fill_in "Zh tw content", with: @additional.zh_tw_content
    fill_in "Zh tw additional link", with: @additional.zh_tw_external_link
    fill_in "Zh tw notes", with: @additional.zh_tw_notes
    fill_in "Zh tw source", with: @additional.zh_tw_source
    fill_in "Zh tw title", with: @additional.zh_tw_title
    click_on "Update Additional"

    assert_text "Additional was successfully updated"
    click_on "Back"
  end

  test "destroying a Additional" do
    visit additionals_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Additional was successfully destroyed"
  end
end
