require File.dirname(__FILE__) + '/../test_helper'
require 'iphone_controller'

# Re-raise errors caught by the controller.
class IphoneController; def rescue_action(e) raise e end; end

class IphoneControllerTest < Test::Unit::TestCase
  def setup
    @controller = IphoneController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
