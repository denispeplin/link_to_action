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

  def self.setup
    yield self
  end
end

I18n.load_path << "#{File.dirname(__FILE__)}/link_to_action/locale/en.yml"