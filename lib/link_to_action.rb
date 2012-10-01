require "link_to_action/version"
require 'link_to_action/helpers'
require 'action_view'
require 'active_model'
require 'active_support'

module LinkToAction
  mattr_accessor :use_cancan
  @@use_cancan = false

  mattr_accessor :use_icons
  @@use_icons = false

  mattr_accessor :icons_size
  @@icons_size = 'large'

  mattr_accessor :icon_new
  @@icon_new = 'plus'

  mattr_accessor :icon_edit
  @@icon_edit = 'edit'

  mattr_accessor :icon_destroy
  @@icon_destroy = 'trash'

  mattr_accessor :icon_back
  @@icon_back = 'undo'

  mattr_accessor :use_classes
  @@use_classes = false

  mattr_accessor :class_default
  @@class_default = 'btn'

  mattr_accessor :class_new
  @@class_new = 'btn-primary'

  mattr_accessor :class_edit
  @@class_edit = nil

  mattr_accessor :class_destroy
  @@class_destroy = 'btn-danger'

  mattr_accessor :class_back
  @@class_back = nil

  mattr_accessor :size_class_default
  @@size_class_default = nil

  mattr_accessor :size_class_large
  @@size_class_large = 'btn-large'

  mattr_accessor :size_class_small
  @@size_class_small = 'btn-small'

  mattr_accessor :size_class_mini
  @@size_class_mini = 'btn-mini'
  def self.setup
    yield self
  end
end

I18n.load_path << "#{File.dirname(__FILE__)}/link_to_action/locale/en.yml"