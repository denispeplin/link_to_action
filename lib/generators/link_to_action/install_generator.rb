require 'rails/generators'
require 'rails/generators/named_base'

module LinkToAction
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Copy LinkToAction configuration file"
      source_root File.expand_path('../templates', __FILE__)

      def copy_initializers
        copy_file 'link_to_action.rb', 'config/initializers/link_to_action.rb'
      end

      def copy_locale_file
        copy_file '../../../link_to_action/locale/en.yml',
          'config/locales/link_to_action.en.yml'
      end
      
      def copy_templates
        # TODO: one LOC
        copy_file 'edit.html.erb', 'lib/templates/erb/scaffold/edit.html.erb'
        copy_file 'index.html.erb', 'lib/templates/erb/scaffold/index.html.erb'
        copy_file 'new.html.erb', 'lib/templates/erb/scaffold/new.html.erb'
        copy_file 'show.html.erb', 'lib/templates/erb/scaffold/show.html.erb'
      end
    end
  end
end