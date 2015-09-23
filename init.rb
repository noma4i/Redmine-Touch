require 'redmine'
require_dependency 'user_update'

Redmine::Plugin.register :redmine_touch do
  name 'Touch'
  author 'Alex Tsirel'
  description 'Add functionality of *who updated this last*'
  version '0.0.3'
  url 'https://github.com/noma4i/Redmine-Touch'
  author_url 'https://github.com/noma4i'
  requires_redmine :version_or_higher => '2.0.0'
end
