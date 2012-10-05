require 'rails/generators'
require 'rails/generators/named_base'

module LinkToAction
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Copy LinkToAction configuration file"
      source_root File.expand_path('../../..', __FILE__)

      def copy_initializers
        copy_file 'generators/link_to_action/templates/link_to_action.rb',
          'config/initializers/link_to_action.rb'
      end

      def copy_locale_file
        copy_file 'link_to_action/locale/en.yml',
          'config/locales/link_to_action.en.yml'
      end
    end
  end
end