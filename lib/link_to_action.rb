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

  def self.setup
    yield self
  end
end

I18n.load_path << "#{File.dirname(__FILE__)}/link_to_action/locale/en.yml"