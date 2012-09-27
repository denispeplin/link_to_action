require "link_to_action/version"
require 'action_view'
require 'active_model'
require 'active_support'

module LinkToAction
  def link_to_new(object, options = {})
    link_to_action(:new, object, options)
  end

  def link_to_edit(object, options = {})
    link_to_action(:edit, object, options)
  end

  private

  ICONS = {new: 'plus', edit: 'edit'}

  def link_to_action(action, object, options)
    name = options.delete(:name) || t_action(object, action)
    params = options.delete(:params) || {}
    params[:action] = action
    # TODO: make icon and can? optional
    ilink_to "#{LinkToAction::ICONS[action]} large", name,
      polymorphic_url(object, params), options if can?(action, object)
  end

  def ilink_to(*args)
    icon = args[0].split(' ').map {|i| "icon-#{i}"}.join(' ')
    name = args[1]
    options = args.from(2)
    link_to raw("#{icon} #{ERB::Util.html_escape(name)}"), options
  end

  # TODO: inspect some advanced I18n
  # actionpack/lib/action_view/helpers/form_helper.rb, submit_default_value
  def t_action(object, action)
    model = if object.respond_to?(:model_name)
      object.model_name.human
    else
      object.class.model_name.human
    end

    t(:"helpers.link_to.#{action}", model: model)
  end
end

ActionView::Base.send :include, LinkToAction

I18n.load_path << "#{File.dirname(__FILE__)}/link_to_action/locale/en.yml"