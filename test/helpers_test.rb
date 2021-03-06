require 'test_helper'

class HelperTest < ActionView::TestCase
  test 'link_to_new' do
    assert_equal "<a href=\"/users/new\">New My User</a>",
      link_to_new(User)
  end

  test 'link_to_new nested' do
    assert_equal "<a href=\"/users/1/comments/new\">New My Comment</a>",
      link_to_new([@user, Comment])
  end
  
  test 'link_to_index' do
    assert_equal "<a href=\"/users\">My Users</a>", link_to_index(User)
  end

  test 'link_to_index when icons and classes enabled' do
    swap LinkToAction, use_icons: true, use_classes: true do
      assert_equal "<a href=\"/users\">My Users</a>", link_to_index(User)
    end
  end

  test 'link_to_show' do
    assert_equal "<a href=\"/users/1\">#{@user.name}</a>",
      link_to_show(@user)
  end
  
  test 'link_to_show using custom method' do
    assert_equal "<a href=\"/users/1\">#{@user.login}</a>",
      link_to_show(@user, send: :login)
  end

  test 'link_to_show using custom method raw' do
    user = @user
    user.login = '<a href="http://example.com">example</a>'
    assert_equal "<a href=\"/users/1\">#{user.login}</a>",
      link_to_show(user, raw: :login)
  end
  
  test 'link_to_show using i18n text instead of sending method' do
    user = @user
    user.login = '<a href="http://example.com">example</a>'
    assert_equal "<a href=\"/users/1\">Show</a>",
      link_to_show(user, i18n: true)
  end

  test 'link_to_edit' do
    assert_equal "<a href=\"/users/1/edit\">Edit</a>", link_to_edit(@user)
  end

  test 'link_to_destroy' do
    assert_equal "<a href=\"/users/1\" data-confirm=\"Are you sure?\" data-method=\"delete\" rel=\"nofollow\">Delete</a>",
      link_to_destroy(@user)
  end
  
  test 'link_to_destroy with skip_pjax' do
    swap LinkToAction, destroy_skip_pjax: true do
      assert_equal "<a href=\"/users/1\" data-confirm=\"Are you sure?\" data-method=\"delete\" data-skip-pjax=\"true\" rel=\"nofollow\">Delete</a>",
        link_to_destroy(@user)
    end
  end

  test 'link_to_destroy without confirm' do
    swap LinkToAction, destroy_confirm: false do
      assert_equal "<a href=\"/users/1\" data-method=\"delete\" rel=\"nofollow\">Delete</a>",
        link_to_destroy(@user)
    end
  end
  
  test 'link_to_destroy with per-link confirm' do
    swap LinkToAction, destroy_confirm: false do
      assert_equal "<a href=\"/users/1\" data-confirm=\"Are you sure?\" data-method=\"delete\" rel=\"nofollow\">Delete</a>",
        link_to_destroy(@user, confirm: true)
    end
  end
  
  test 'link_to_destroy with per-link confirm and specific text' do
    swap LinkToAction, destroy_confirm: false do
      assert_equal "<a href=\"/users/1\" data-confirm=\"Are you really sure?\" data-method=\"delete\" rel=\"nofollow\">Delete</a>",
        link_to_destroy(@user, confirm: 'Are you really sure?')
    end
  end

  test 'link_to_destroy without per-link confirm' do
    assert_equal "<a href=\"/users/1\" data-method=\"delete\" rel=\"nofollow\">Delete</a>",
      link_to_destroy(@user, confirm: false)
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

  test 'link_to_back with icon on the right side' do
    swap LinkToAction, use_icons: true, icons_place_left: false do
      assert_equal "<a href=\"javascript:history.back()\">Back <i class=\"icon-undo icon-large\"></i></a>",
        link_to_back
    end
  end
  test 'link_to_back swapping icon_position' do
    swap LinkToAction, use_icons: true do
      assert_equal "<a href=\"javascript:history.back()\">Back <i class=\"icon-undo icon-large\"></i></a>",
        link_to_back(icon_swap: true)
    end
  end

  test 'link_to_back specifying icon' do
    swap LinkToAction, use_icons: true do
      assert_equal "<a href=\"javascript:history.back()\"><i class=\"icon-chevron-left icon-large\"></i> Back</a>",
        link_to_back(icon: 'chevron-left')
    end
  end

  test 'link_to_back specifying icon size' do
    swap LinkToAction, use_icons: true do
      assert_equal "<a href=\"javascript:history.back()\"><i class=\"icon-undo icon-small\"></i> Back</a>",
        link_to_back(icon_size: :small)
    end
  end

    test 'link_to_back specifying default icon size' do
    swap LinkToAction, use_icons: true do
      assert_equal "<a href=\"javascript:history.back()\"><i class=\"icon-undo\"></i> Back</a>",
        link_to_back(icon_size: :default)
    end
  end
  
  test 'link_to_back first time with classes' do
    swap LinkToAction, use_classes: true do
      assert_equal "<a href=\"javascript:history.back()\" class=\"btn\">Back</a>",
        link_to_back
    end
  end

  test 'link_to_back drop classes' do
    swap LinkToAction, use_classes: true do
      assert_equal "<a href=\"javascript:history.back()\">Back</a>",
        link_to_back(class: '')
    end
  end

  test 'link_to_back append classes' do
    swap LinkToAction, use_classes: true, classes_append: true do
      assert_equal "<a href=\"javascript:history.back()\" class=\"btn btn-warning\">Back</a>",
        link_to_back(class: 'btn-warning')
    end
  end
end
