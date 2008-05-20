require File.dirname(__FILE__) + '/../test_helper'
require 'site_controller'
require_dependency 'site_controller_ext'

# Re-raise errors caught by the controller.
class SiteController; def rescue_action(e) raise e end; end

class SiteControllerTest < Test::Unit::TestCase
  fixtures :layouts, :pages, :page_parts
  test_helper :pages
  
  def setup
    SiteController.send :include, FileBasedLayout::SiteControllerExt
    @controller = SiteController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @cache      = @controller.cache
    @cache.perform_caching = false
    @cache.clear
  end

  def test_show_page_with_radiant_layout
    get :show_page, :url => pages(:page_with_layout).slug
    assert_response :success
    assert_match %r{<html>}, @response.body
    assert_match %r{Page With Layout}, @response.body
  end

  def test_show_page_with_file_based_layout
    get :show_page, :url => pages(:page_with_file_based_layout).slug
    assert_response :success
    assert_match %r{<h1>Body:</h1>}, @response.body
    assert_match %r{Body: Page With File Based Layout}, @response.body
    assert_match %r{<h1>Extended:</h1>}, @response.body
    assert_match %r{Extended: Page With File Based Layout}, @response.body
  end
  
end
