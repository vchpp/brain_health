require "test_helper"

class AdditionalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @additional = additionals(:one)
  end

  test "should get index" do
    get additionals_url
    assert_response :success
  end

  test "should get new" do
    get new_additional_url
    assert_response :success
  end

  test "should create additional" do
    assert_difference('Additional.count') do
      post additionals_url, params: { additional: { en_content: @additional.en_content, en_additional_link: @additional.en_additional_link, en_notes: @additional.en_notes, en_source: @additional.en_source, en_title: @additional.en_title, hm_content: @additional.hm_content, hm_additional_link: @additional.hm_additional_link, hm_notes: @additional.hm_notes, hm_source: @additional.hm_source, hm_title: @additional.hm_title, languages: @additional.languages, last_version_date: @additional.last_version_date, vi_content: @additional.vi_content, vi_additional_link: @additional.vi_additional_link, vi_notes: @additional.vi_notes, vi_source: @additional.vi_source, vi_title: @additional.vi_title, zh_cn: @additional.zh_cn, zh_cn_content: @additional.zh_cn_content, zh_cn_additional_link: @additional.zh_cn_additional_link, zh_cn_notes: @additional.zh_cn_notes, zh_cn_title: @additional.zh_cn_title, zh_tw_content: @additional.zh_tw_content, zh_tw_additional_link: @additional.zh_tw_additional_link, zh_tw_notes: @additional.zh_tw_notes, zh_tw_source: @additional.zh_tw_source, zh_tw_title: @additional.zh_tw_title } }
    end

    assert_redirected_to additional_url(Additional.last)
  end

  test "should show additional" do
    get additional_url(@additional)
    assert_response :success
  end

  test "should get edit" do
    get edit_additional_url(@additional)
    assert_response :success
  end

  test "should update additional" do
    patch additional_url(@additional), params: { additional: { en_content: @additional.en_content, en_additional_link: @additional.en_additional_link, en_notes: @additional.en_notes, en_source: @additional.en_source, en_title: @additional.en_title, hm_content: @additional.hm_content, hm_additional_link: @additional.hm_additional_link, hm_notes: @additional.hm_notes, hm_source: @additional.hm_source, hm_title: @additional.hm_title, languages: @additional.languages, last_version_date: @additional.last_version_date, vi_content: @additional.vi_content, vi_additional_link: @additional.vi_additional_link, vi_notes: @additional.vi_notes, vi_source: @additional.vi_source, vi_title: @additional.vi_title, zh_cn: @additional.zh_cn, zh_cn_content: @additional.zh_cn_content, zh_cn_additional_link: @additional.zh_cn_additional_link, zh_cn_notes: @additional.zh_cn_notes, zh_cn_title: @additional.zh_cn_title, zh_tw_content: @additional.zh_tw_content, zh_tw_additional_link: @additional.zh_tw_additional_link, zh_tw_notes: @additional.zh_tw_notes, zh_tw_source: @additional.zh_tw_source, zh_tw_title: @additional.zh_tw_title } }
    assert_redirected_to additional_url(@additional)
  end

  test "should destroy additional" do
    assert_difference('Additional.count', -1) do
      delete additional_url(@additional)
    end

    assert_redirected_to additionals_url
  end
end
