class ProjectCopyHook < Redmine::Hook::ViewListener
  render_on :view_projects_show_left, :partial => 'project_copy/copy_link'
end
