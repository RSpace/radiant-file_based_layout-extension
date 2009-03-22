require_dependency 'application'
require_dependency 'layout_ext'
require_dependency 'site_controller_ext'
require_dependency 'layout_controller_ext'

class FileBasedLayoutExtension < Radiant::Extension
  version "1.0"
  description "Allows pages served by Radiant to share a standard file-based Rails layout with Rails-generated pages"
  url "http://svn.casperfabricius.com/extensions/file_based_layout/"
  
  def activate
    Layout.send :include, FileBasedLayout::LayoutExt
    SiteController.send :include, FileBasedLayout::SiteControllerExt
    Admin::LayoutsController.send :include, FileBasedLayout::LayoutControllerExt
    admin.layout.edit.add :extended_metadata, 'file_based_layout_column'
    #page.index.add :node, 'file_based_layout_column'
  end
  
  def deactivate
  end
  
end