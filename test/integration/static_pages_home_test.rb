require 'test_helper'

class UsersHome < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "stats when logged in" do
    log_in_as(@user)
    get root_path
    assert_select "a[href=?]", following_user_path(@user)
    assert_select "a[href=?]", followers_user_path(@user)
  end

  test "stats when not logged in" do
    get root_path
    assert_select "a[href=?]", following_user_path(@user), count: 0
    assert_select "a[href=?]", followers_user_path(@user), count: 0
  end
  
end
