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
    assert_select 'strong#following', @user.following.count.to_s
    assert_select 'strong#followers', @user.followers.count.to_s
  end

  test "stats when not logged in" do
    get root_path
    assert_select "a[href=?]", following_user_path(@user), count: 0
    assert_select "a[href=?]", followers_user_path(@user), count: 0
    assert_select 'strong#following', count: 0 
    assert_select 'strong#followers', count: 0
  end
  
end
