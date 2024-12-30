require "test_helper"

class InspirationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @inspiration = inspirations(:one)
  end

  test "should get index" do
    get inspirations_url
    assert_response :success
  end

  test "should get new" do
    get new_inspiration_url
    assert_response :success
  end

  test "should create inspiration" do
    assert_difference('inspiration.count') do
      post inspirations_url, params: { inspiration: { archive: @inspiration.archive, category: @inspiration.category, en_inspiration: @inspiration.en_inspiration, featured: @inspiration.featured, hm_inspiration: @inspiration.hm_inspiration, ko_inspiration: @inspiration.ko_inspiration, priority: @inspiration.priority, tags: @inspiration.tags, vi_inspiration: @inspiration.vi_inspiration, zh_cn_inspiration: @inspiration.zh_cn_inspiration, zh_tw_inspiration: @inspiration.zh_tw_inspiration } }
    end

    assert_redirected_to inspiration_url(inspiration.last)
  end

  test "should show inspiration" do
    get inspiration_url(@inspiration)
    assert_response :success
  end

  test "should get edit" do
    get edit_inspiration_url(@inspiration)
    assert_response :success
  end

  test "should update inspiration" do
    patch inspiration_url(@inspiration), params: { inspiration: { archive: @inspiration.archive, category: @inspiration.category, en_inspiration: @inspiration.en_inspiration, featured: @inspiration.featured, hm_inspiration: @inspiration.hm_inspiration, ko_inspiration: @inspiration.ko_inspiration, priority: @inspiration.priority, tags: @inspiration.tags, vi_inspiration: @inspiration.vi_inspiration, zh_cn_inspiration: @inspiration.zh_cn_inspiration, zh_tw_inspiration: @inspiration.zh_tw_inspiration } }
    assert_redirected_to inspiration_url(@inspiration)
  end

  test "should destroy inspiration" do
    assert_difference('inspiration.count', -1) do
      delete inspiration_url(@inspiration)
    end

    assert_redirected_to inspirations_url
  end
end
