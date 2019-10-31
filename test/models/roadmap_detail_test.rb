require 'test_helper'

# RoadmapDetailのモデルテスト
class RoadmapDetailTest < ActiveSupport::TestCase
  def setup
    @roadmap_header = roadmap_headers(:ruby)
    @roadmap_detail = @roadmap_header.build_roadmap_detail(sub_title: "First rails", pic_pass1: "", pic_pass2: "", pic_pass3: "", pic_pass4: "", time_required: 20, time_required_unit: 2, content: "lesson ABC")

    @user = users(:general_user)
    @roadmap_pc = roadmap_headers(:pc)
  end

  test "正常に値が入っているときはtrue" do
    # roadmap_header_id：数値で判定
    assert_equal @roadmap_detail.roadmap_header_id, @roadmap_header.id
    # roadmap_header：@roadmap_headerそのものが入っている
    assert_equal @roadmap_detail.roadmap_header, @roadmap_header
    assert @roadmap_detail.valid?
  end

  test "roadmap_header_idが不足しているときfalse" do
    assert @roadmap_detail.valid?
    @roadmap_detail.roadmap_header = nil
    assert_not @roadmap_detail.valid?
  end

  test "sub_title should be present" do
    assert @roadmap_detail.valid?
    @roadmap_detail.sub_title = "   "
    assert_not @roadmap_detail.valid?
  end

  test "sub_title should be at most 100 characters" do
    assert @roadmap_detail.valid?
    @roadmap_detail.sub_title = "a" * 101
    assert_not @roadmap_detail.valid?
  end

  test "pic_pass1 should be at most 300 characters" do
    assert @roadmap_detail.valid?
    @roadmap_detail.pic_pass1 = "a" * 301
    assert_not @roadmap_detail.valid?
  end

  test "pic_pass2 should be at most 300 characters" do
    assert @roadmap_detail.valid?
    @roadmap_detail.pic_pass2 = "a" * 301
    assert_not @roadmap_detail.valid?
  end

  test "pic_pass3 should be at most 300 characters" do
    assert @roadmap_detail.valid?
    @roadmap_detail.pic_pass3 = "a" * 301
    assert_not @roadmap_detail.valid?
  end

  test "pic_pass4 should be at most 300 characters" do
    assert @roadmap_detail.valid?
    @roadmap_detail.pic_pass4 = "a" * 301
    assert_not @roadmap_detail.valid?
  end

  test "content should be present" do
    assert @roadmap_detail.valid?
    @roadmap_detail.content = "   "
    assert_not @roadmap_detail.valid?
  end

  test "content should be at most 50000 characters" do
    assert @roadmap_detail.valid?
    @roadmap_detail.content = "a" * 50001
    assert_not @roadmap_detail.valid?
  end

  test "ユーザーを削除するとroadmap_detailも削除" do
    assert_difference 'RoadmapDetail.count', -1 do
      @user.destroy
    end
  end

  test "roadmap_headerを削除するとroadmap_detailも削除" do
    assert_difference 'RoadmapDetail.count', -1 do
      @roadmap_pc.destroy
    end
  end
end
