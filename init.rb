require 'redmine'
require 'application_helper'

Redmine::Plugin.register :redmine_roadmap_module do
	name 'Redmine remove Homepage'
	description 'A plugin to change order of project menu items.'
	url 'https://github.com/mephi-ut/redmine_roadmap_module'
	author 'Dmitry Yu Okunev'
	author_url 'https://github.com/xaionaro'
	version '0.0.1'
	delete_menu_item :project_menu, :roadmap

	menu :project_menu, :roadmap, { :controller => 'versions', :action => 'index' }, :param => :project_id, :if => Proc.new { |p| p.shared_versions.any? && User.current.allowed_to?({:controller => :versions, :action => :index}, p) && p.module_enabled?("roadmap") }

	project_module :roadmap do
		permission :view_versions, :versions => :index
	end
end

