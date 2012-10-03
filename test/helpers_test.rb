require 'test_helper'

class HelperTest < ActionView::TestCase
  test 'link_to_new' do
    assert_equal "<a href=\"/users/new\">New User</a>",
      link_to_new(User)
  end

  test 'link_to_edit' do
    assert_equal "<a href=\"/users/1/edit\">Edit User</a>", link_to_edit(@user)
  end

  test 'link_to_destroy' do
    assert_equal "<a href=\"/users/1\" data-confirm=\"Are you sure?\" data-method=\"delete\" data-skip-pjax=\"true\" rel=\"nofollow\">Delete User</a>",
      link_to_destroy(@user)
  end

  test 'link_to_destroy with cancan disallowed' do
    swap LinkToAction, use_cancan: true do
      assert_equal nil, link_to_destroy(@user)
    end
  end

  test 'link_to_back first time' do
    assert_equal "<a href=\"javascript:history.back()\">Back</a>",
      link_to_back
  end

  test 'link_to_back with size' do
    assert_equal "<a href=\"javascript:history.back()\" class=\"btn-mini\">Back</a>",
      link_to_back(size: :mini)
  end

  test 'link_to_back using icons' do
    swap LinkToAction, use_icons: true do
      assert_equal "<a href=\"javascript:history.back()\"><i class=\"icon-undo icon-large\"></i> Back</a>",
        link_to_back
    end
  end

  test 'link_to_back specifying icon size' do
    swap LinkToAction, use_icons: true do
      assert_equal "<a href=\"javascript:history.back()\"><i class=\"icon-undo icon-small\"></i> Back</a>",
        link_to_back(icon_size: :small)
    end
  end
  
  test 'link_to_back first time with classes' do
    swap LinkToAction, use_classes: true do
      assert_equal "<a href=\"javascript:history.back()\" class=\"btn\">Back</a>",
        link_to_back
    end
  end
end