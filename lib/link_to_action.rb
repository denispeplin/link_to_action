require "link_to_action/version"
require 'action_view'
require 'active_model'

module LinkToAction
  def link_to_new(object, options = {})
    name = options.delete(:name) || t_action(object, :create)
    params = options.delete(:params) || {}
    params[:action] = :new
    ilink_to 'plus large', name, polymorphic_url(object, params), options
  end

  private

  def ilink_to(*args)
    icon = args[0]
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

    t(:"helpers.submit.#{action}", model: model)
  end
end

ActionView::Base.send :include, LinkToAction