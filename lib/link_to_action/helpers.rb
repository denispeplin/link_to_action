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
    if (options.has_key? :confirm)
      confirm = options.delete(:confirm)
    else
      confirm = LinkToAction.destroy_confirm
    end
    if confirm
      if confirm.kind_of?(String)
        confirm_text = confirm
      else
        confirm_text = t(:'helpers.link_to.destroy_confirm')
      end
      options[:data] = { :confirm => confirm_text }
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
    i18n = options.delete(:i18n)
    unless name or i18n
      method = raw || send ||
        LinkToAction.show_methods.find { |m| object.respond_to?(m) }
      name = object.send(method)
      name = raw(name) if raw
    end
    
    if i18n
      options[:name] = name
      link_to_action :show, object, options
    else
      link_to name, object, options
    end
  end

  # TODO: Find the way to move this to separate module without loosing access to Rails helpers
  # TODO: all these LinkToAction:: are not DRY, do something with this
  private
  
  def link_to_action(action, object, options)
    name = options.delete(:name) || LinkToAction::Utils.t_action(object, action)
    params = options.delete(:params) || {}
    params[:action] = action if [ :new, :edit ].include? action
    options[:class] = LinkToAction::Utils.action_class(action, options)
    name = LinkToAction::Utils.add_icon_to_name(action, name, options)
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

  def link_to_action_cancan?(action, object)
    object = (object.is_a?(Array) ? Hash[*object] : object)
    action == :back || (LinkToAction.use_cancan ? can?(action, object) : true)
  end
end

ActionView::Base.send :include, LinkToAction::Helpers
