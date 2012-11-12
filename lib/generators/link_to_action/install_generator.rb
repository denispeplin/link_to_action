require 'rails/generators'
require 'rails/generators/named_base'

module LinkToAction
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Copy LinkToAction configuration file"
      source_root File.expand_path('../templates', __FILE__)
      class_option :bootstrap, type: :boolean,
        desc: 'Add the Twitter Bootstrap option and templates.'

      def info_framework
        puts "link_to_action supports Twitter Bootstrap. If you want a " \
          "configuration that is compatible with this framework, then please " \
          "re-run this generator with --bootstrap option." unless options.bootstrap?
      end

      def copy_initializers
        copy_file 'link_to_action.rb', 'config/initializers/link_to_action.rb'
        if options[:bootstrap]
          gsub_file 'config/initializers/link_to_action.rb',
            %r|# config.use_icons = false|, 'config.use_icons = true'
          gsub_file 'config/initializers/link_to_action.rb',
            %r|# config.use_classes = false|, 'config.use_classes = true'
        end
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