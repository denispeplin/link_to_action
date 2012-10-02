require 'test_helper'

class HelperTest < ActionView::TestCase
  test 'link_to_new' do
    assert_equal "<a href=\"/users/new\">New User</a>",
      link_to_new(User), '/path'
  end

  test 'link_to_back first time' do
    assert_equal "<a href=\"javascript:history.back()\">Back</a>",
      link_to_back
  end
  
  test 'link_to_back first time with classes' do
    swap LinkToAction, use_classes: true do
      assert_equal "<a href=\"javascript:history.back()\" class=\"btn\">Back</a>",
        link_to_back
    end
  end
end