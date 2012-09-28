require 'rails/generators'
require 'rails/generators/named_base'

module LinkToActions
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Copy LinkToAction configuration file"
      source_root File.expand_path('../templates', __FILE__)

      def copy_initializers
        copy_file 'link_to_action.rb', 'config/initializers/link_to_action.rb'
      end
    end
  end
end