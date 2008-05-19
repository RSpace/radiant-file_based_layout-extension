require File.dirname(__FILE__) + '/../test_helper'

class LayoutTest < Test::Unit::TestCase
  fixtures :layouts
  
  def setup
  end
  
  def test_file_based_attribute
    assert_equal false, layouts(:main).file_based?, "Normal main layout shouldn't be file based"
    assert layouts(:file_based).file_based?, "File based layout should be file based"
  end
  
end
