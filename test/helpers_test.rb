require 'test_helper'

class HelperTest < ActionView::TestCase
  test 'link_to_back first time' do
    assert_equal "<a href=\"javascript:history.back()\">Back</a>",
      link_to_back
  end

  LinkToAction.use_classes
  test 'link_to_back first time with classes' do
    LinkToAction.use_classes = true
    assert_equal "<a href=\"javascript:history.back()\" class=\"btn\">Back</a>",
      link_to_back
  end
end