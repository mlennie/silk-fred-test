require 'test_helper'

class MontagesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get montages_show_url
    assert_response :success
  end

end
