require 'test_helper'

class DefaultValuesTest < ActiveSupport::TestCase
  DEFAULT_VALUES = {
    use_cancan: false,
    use_icons: false,
    icons_size: 'large',
    icon_new: 'plus',
    icon_edit: 'edit',
    icon_destroy: 'trash',
    icon_back: 'undo',
    use_classes: false,
    class_default: 'btn',
    class_new: 'btn-primary',
    class_edit: nil,
    class_destroy: 'btn-danger',
    class_back: nil,
    size_class_default: nil,
    size_class_large: 'btn-large',
    size_class_small: 'btn-small',
    size_class_mini: 'btn-mini',
  }

  DEFAULT_VALUES.each do |key, value|
    test key.to_s do
      assert_equal value, LinkToAction.send(key)
    end
  end
end