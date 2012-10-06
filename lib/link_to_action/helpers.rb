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

  # TODO: Move to separate module to avoid clashes
  private
  
  def ut
    LinkToAction::Utils::utils_test
  end
  
  def action_class(action, options)
    if LinkToAction.use_classes
      class_default = LinkToAction.class_default
      class_action = LinkToAction.send("class_#{action}")
    end
    size = options.delete(:size) || 'default'
    classes = []
    classes = [ class_default, class_action ] unless class_action == ''
    if options[:class]
      classes = if LinkToAction.classes_append
        classes.concat [ options[:class] ]
      else
        [ options[:class] ]
      end
    end
    classes = classes.concat([ size_class(size) ]).compact.join(' ')
    classes unless classes.blank?
  end

  def size_class(size)
    LinkToAction.send("size_class_#{size}")
  end

  def link_to_action(action, object, options)
    name = options.delete(:name) || t_action(object, action)
    params = options.delete(:params) || {}
    params[:action] = action if [ :new, :edit ].include? action
    options[:class] = action_class(action, options)
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
    icon_swap = options.delete(:icon_swap)
    if LinkToAction.use_icons && icon
      icon = "<i class=\"#{icon}\"></i>"
      name = [icon, ERB::Util.html_escape(name) ]
      name.reverse! unless LinkToAction.icons_place_left
      name.reverse! if icon_swap
      name = raw(name.join(' '))
    end
    link_to name, path, options
  end

  # TODO: inspect some advanced I18n
  # actionpack/lib/action_view/helpers/form_helper.rb, submit_default_value
  def t_action(object, action)
    object = object.last if object.kind_of? Array
    model = if object.respond_to?(:model_name)
      object.model_name.human
    else
      object.class.model_name.human if object.class.respond_to?(:model_name)
    end
    
    model = model.pluralize if action == :index

    t(:"helpers.link_to.#{action}", model: model)
  end
end

ActionView::Base.send :include, LinkToAction::Helpers
