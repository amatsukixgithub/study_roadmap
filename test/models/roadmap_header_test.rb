require 'test_helper'

class RoadmapHeaderTest < ActiveSupport::TestCase
  def setup
    @user = users(:general_user)
    @roadmap_header = @user.roadmap_header.build(title: "Beautiful Title")

    @roadmap_ruby = roadmap_headers(:ruby)
  end

  test "should be valid" do
    assert_equal @roadmap_header.user_id, @user.id
    assert_equal @roadmap_header.title, "Beautiful Title"
    assert @roadmap_header.valid?
  end

  test "user id should be present" do
    @roadmap_header.user_id = nil
    assert_not @roadmap_header.valid?
  end

  test "title should be present" do
    @roadmap_header.title = "   "
    assert_not @roadmap_header.valid?
  end

  test "title should be at most 50 characters" do
    @roadmap_header.title = "a" * 51
    assert_not @roadmap_header.valid?
  end

  test "assumption_lebel should be at most 50 characters" do
    @roadmap_header.title = "a" * 401
    assert_not @roadmap_header.valid?
  end

  test "order should be most recent first" do
    assert_equal roadmap_headers(:most_recent), RoadmapHeader.first
  end

  test "ユーザーを削除するとroadmap_headerも削除" do
    assert_difference 'RoadmapHeader.count', -4 do
      @user.destroy
    end
  end

  test "roadmap_headerを1つ削除" do
    assert_difference 'RoadmapHeader.count', -1 do
      @roadmap_ruby.destroy
    end
  end
end
