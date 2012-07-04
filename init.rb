require 'redmine' if Redmine::VERSION::MAJOR <= 1
require 'project_copy_hook'
require 'project_copy_projects_controller_patch'

Redmine::Plugin.register :redmine_project_copy do
  name 'Redmine Project Copy plugin'
  author 'OZAWA Yasuhiro'
  description 'Not admin users can copy project.'
  version '0.0.1'
  url 'https://github.com/ameya86/redmine_project_copy'
  author_url 'http://blog.livedoor.jp/ameya86/'

  # コピー権限
  permission :project_copy, :projects => [ :copy ], :require => :member
end
