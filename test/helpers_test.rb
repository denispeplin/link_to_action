require 'test_helper'

class HelperTest < ActionView::TestCase
  test 'link_to_back returns javascript for the first time' do
    assert_equal "<a href=\"javascript:history.back()\" class=\"btn\">Back</a>",
      link_to_back
  end
end