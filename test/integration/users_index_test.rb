# coding: utf-8
require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:michael)
    @non_admin = users(:archer)
  end

  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), text: 'delete'
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end

  test "index as non-admin" do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end

  test "/users/:id activated" do
    log_in_as(@admin) #ログインする
    get user_path(@non_admin) #@non_adminのプロフィールを見に行く
    assert_template 'users/show' #プロフィールが表示されていることを確認
  end

  test "/users/:id inactivated" do
    log_in_as(@admin) #ログインする
    @non_admin.update_attribute(:activated, false)  #@non_adminのactivatedをfalseにする
    get user_path(@non_admin) #@non_adminのプロフィールを見に行く
    follow_redirect!
    assert_template 'static_pages/home' #homeが表示されていることを確認
  end

  test "/users" do
    log_in_as(@admin) #ログインする
    @non_admin.update_attribute(:activated, false)  #@non_adminのactivateをfalseにする
    get users_path
    i = assigns(:users).total_pages
    for page in 1..i do
      get users_path, page: page   #usersを見る
      assert_select 'a[href=?]', user_path(@non_admin), text: @non_admin.name, count: 0  #@non_adminが表示されていないことを確認
    end
  end
  
end
