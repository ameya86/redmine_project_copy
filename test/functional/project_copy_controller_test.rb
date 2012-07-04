require File.dirname(__FILE__) + '/../test_helper'

class ProjectCopyControllerTest < ActionController::TestCase
#  fixtures :users, :projects, :members, :member_roles, :roles
  fixtures :all

  def setup
    @controller = ProjectsController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
    User.current = nil

    # Managerロールにコピー権限を与える
    role = Role.find_by_name("Manager")
    role.add_permission!(:project_copy)
  end

  # Managerはコピー画面を開ける
  def test_copy_manager
    @request.session[:user_id] = 2
    get :copy, :id => 'ecookbook'
    assert_response :success

    # 存在しないプロジェクトでは404
    get :copy, :id => '404'
    assert_response 404
  end

  # Managerでなければ開けない
  def test_copy_developer
    @request.session[:user_id] = 3
    get :copy, :id => 'ecookbook'
    assert_response 403

    # id2のユーザもManagerでないプロジェクトではコピーできない
    @request.session[:user_id] = 2
    get :copy, :id => 'onlinestore'
    assert_response 403

    # 未ログインユーザもコピー不可
    @request.session[:user_id] = User.anonymous.id
    get :copy, :id => 'onlinestore'
    assert_response 403
  end

  # Adminは開ける
  def test_copy_admin
    @request.session[:user_id] = 1
    get :copy, :id => 'ecookbook'
    assert_response :success
  end
end
