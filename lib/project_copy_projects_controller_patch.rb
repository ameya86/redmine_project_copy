require_dependency 'projects_controller'

# プロジェクトコントローラを修正
class ProjectsController < ApplicationController
  # copyアクションの認証を無くす
  skip_before_filter :require_admin, :only => [ :copy ]
  before_filter :authorize_copy, :only => [ :copy ]

  # コピー権限の確認
  def authorize_copy
    find_project unless @project
    if @project.nil? || @project.new_record?
      render_404
    else
      render_403 unless User.current.allowed_to?(:project_copy, @project)
    end
  end
end
