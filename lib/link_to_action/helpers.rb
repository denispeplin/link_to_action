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
    if LinkToAction.destroy_confirm
      options[:data] = { :confirm => t(:'helpers.link_to.destroy_confirm') }
    end
    options['data-skip-pjax'] = true if LinkToAction.destroy_skip_pjax
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

  # TODO: Find the way to move this to separate module without loosing access to Rails helpers
  # TODO: all these LinkToAction:: are not DRY, do something with this
  private
  
  def link_to_action(action, object, options)
    name = options.delete(:name) || LinkToAction::Utils::t_action(object, action)
    params = options.delete(:params) || {}
    params[:action] = action if [ :new, :edit ].include? action
    options[:class] = LinkToAction::Utils::action_class(action, options)
    name = LinkToAction::Utils::add_icon_to_name(action, name, options)
    if link_to_action_cancan?(action, object)
      link_to name, link_to_action_path(action, object, params), options
    end
  end

  def link_to_action_path(action, object, params)
    if action == :back
      action
    else
      polymorphic_path(object, params)
    end
  end

  def link_to_action_cancan?(*args)
    args[0] == :back || ( LinkToAction.use_cancan ? can?(*args) : true )
  end
end

ActionView::Base.send :include, LinkToAction::Helpers
