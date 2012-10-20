require 'test_helper'

class DefaultValuesTest < ActiveSupport::TestCase
  DEFAULT_VALUES = {
    use_cancan: false,
    use_icons: false,
    icons_size: 'large',
    icons_place_left: true,
    icon_new: 'plus',
    icon_show: '',
    icon_index: '',
    icon_edit: 'edit',
    icon_destroy: 'trash',
    icon_back: 'undo',
    use_classes: false,
    classes_append: false,
    class_default: 'btn',
    class_new: 'btn-primary',
    class_index: '',
    class_edit: nil,
    class_destroy: 'btn-danger',
    class_back: nil,
    size_class_default: nil,
    size_class_large: 'btn-large',
    size_class_small: 'btn-small',
    size_class_mini: 'btn-mini',
    show_methods: [ :name, :to_s ],
    destroy_confirm: true,
    destroy_skip_pjax: false
  }

  DEFAULT_VALUES.each do |key, value|
    test key.to_s do
      assert_equal value, LinkToAction.send(key)
    end
  end
end
