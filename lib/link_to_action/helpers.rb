# require 'ruby-debug'
# uncomment line above add 'debugger' somewhere (without quotes) to debug something
require_relative 'utils'

module LinkToAction::Helpers
  def link_to_new(object, options = {})
    link_to_action(:new, object, options)
  end

  def link_to_index(object, options = {})
    link_to_action(:index, object, options)
  end

  def link_to_edit(object, options = {})
    link_to_action(:edit, object, options)
  end

  def link_to_destroy(object, options = {})
    options[:method] = :delete
    options[:data] = { :confirm => t(:'helpers.link_to.destroy_confirm') }
    options['data-skip-pjax'] = true
    link_to_action(:destroy, object, options)
  end

  def link_to_back(options = {})
    link_to_action :back, nil, options
  end

  def link_to_show(object, options = {})
    name = options.delete(:name)
    raw = options.delete(:raw)
    send = options.delete(:send)
    unless name
      method = raw || send ||
        LinkToAction.show_methods.find { |m| object.respond_to?(m) }
      name = object.send(method)
    end
    name = raw(name) if raw
    link_to name, object, options
  end

  # TODO: Find the way to move this to separate module
  # without loosing access to Rails helpers
  private
  
  def link_to_action(action, object, options)
    name = options.delete(:name) || LinkToAction::Utils::t_action(object, action)
    params = options.delete(:params) || {}
    params[:action] = action if [ :new, :edit ].include? action
    options[:class] = LinkToAction::Utils::action_class(action, options)
    icon = LinkToAction::Utils::action_icon(action, options)
    iilink_to icon, name, action_path(action, object, params),
      options if cancan?(action, object)
  end

  def action_path(action, object, params)
    if action == :back
      action
    else
      polymorphic_path(object, params)
    end
  end

  def cancan?(*args)
    args[0] == :back || ( LinkToAction.use_cancan ? can?(*args) : true )
  end

  def iilink_to(icon, name, path, options = {})
    name = LinkToAction::Utils::add_icon_to_name(icon, name, options)
    link_to name, path, options
  end
end

ActionView::Base.send :include, LinkToAction::Helpers
