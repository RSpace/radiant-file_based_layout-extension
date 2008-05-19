require File.dirname(__FILE__) + '/../test_helper'

class FileBasedLayoutExtensionTest < Test::Unit::TestCase
  
  def test_initialization
    assert_equal File.join(File.expand_path(RAILS_ROOT), 'vendor', 'extensions', 'file_based_layout'), FileBasedLayoutExtension.root
    assert_equal 'File Based Layout', FileBasedLayoutExtension.extension_name
  end
  
end
