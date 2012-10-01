module LinkToAction::Helpers
  def link_to_new(object, options = {})
    link_to_action(:new, object, options)
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

  # TODO: Move to separate module to avoid clashes
  private

  def action_class(action, options)
    class_default = LinkToAction.class_default
    class_action = LinkToAction.send("class_#{action}")
    if options[:size]
      size_class = LinkToAction.send("size_class_#{options[:size]}")
    else
      size_class = LinkToAction.size_class_default
    end
    [class_default, class_action, size_class, options[:class]].compact.join(' ')
  end

  def action_icon(action)
    [ LinkToAction.send("icon_#{action}"), LinkToAction.icons_size ].join(' ')
  end

  def link_to_action(action, object, options)
    name = options.delete(:name) || t_action(object, action)
    params = options.delete(:params) || {}
    params[:action] = action if [ :new, :edit ].include? action
    options[:class] = action_class(action, options)
    iilink_to action_icon(action), name, action_path(action, object, params),
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
    args[0] == :back || LinkToAction.use_cancan ? can?(*args) : true
  end

  def iilink_to(icon_name, name, path, options = {})
    if LinkToAction.use_icons
      icon_class = icon_name.split(' ').map {|i| "icon-#{i}"}.join(' ')
      icon = "<i class=\"#{icon_class}\"></i>"
      name = raw("#{icon} #{ERB::Util.html_escape(name)}")
    end
    link_to name, path, options
  end

  # TODO: inspect some advanced I18n
  # actionpack/lib/action_view/helpers/form_helper.rb, submit_default_value
  def t_action(object, action)
    model = if object.respond_to?(:model_name)
      object.model_name.human
    else
      object.class.model_name.human if object.class.respond_to?(:model_name)
    end

    t(:"helpers.link_to.#{action}", model: model)
  end
end

ActionView::Base.send :include, LinkToAction::Helpers