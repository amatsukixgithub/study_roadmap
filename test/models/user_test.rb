require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:general_user)
  end

  test "ユーザーに正常に値が入っているときはtrue" do
    assert @user
    assert_equal @user.name, "general"
    assert @user.valid?
  end

  test "nameは空白を許可しない" do
    @user.name = "  "
    assert_not @user.valid?
  end

  test "nameはnilを許可しない" do
    @user.name = nil
    assert_not @user.valid?
  end

  test "nameは空文字を許可しない" do
    @user.name = ""
    assert_not @user.valid?
  end

  test "emailは空白を許可しない" do
    @user.email = "  "
    assert_not @user.valid?
  end

  test "emailはnilを許可しない" do
    @user.email = nil
    assert_not @user.valid?
  end

  test "emailは空文字を許可しない" do
    @user.email = ""
    assert_not @user.valid?
  end

  test "web_pageは401文字以上を許可しない" do
    @user.web_page = "a" * 401
    assert_not @user.valid?
  end

  test "commentは401文字以上を許可しない" do
    @user.comment = "a" * 401
    assert_not @user.valid?
  end
end
