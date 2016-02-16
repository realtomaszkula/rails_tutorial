require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
  end

  def setup
    @user = users(:michael)
    log_in_as @user
  end

  test 'layout links when logged in' do
    assert_redirected_to user_path(@user)
    follow_redirect!
    assert_template 'users/show'

    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path

    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", user_path
    assert_select "a[href=?]", edit_user_path
    assert_select "a[href=?]", logout_path
  end


  test 'layout links when logged out' do
    delete logout_path
    follow_redirect!
    assert_not is_logged_in?
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", users_path,              count: 0
    assert_select "a[href=?]", user_path(@user),        count: 0
    assert_select "a[href=?]", edit_user_path(@user),   count: 0
    assert_select "a[href=?]", logout_path,             count: 0
  end

end
