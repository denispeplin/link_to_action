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
    if LinkToAction.use_classes
      class_default = LinkToAction.class_default
      class_action = LinkToAction.send("class_#{action}")
    end
    size = options.delete(:size) || 'default'
    classes = [ class_default, class_action ]
    if options[:class]
      classes = if LinkToAction.classes_append
        classes.concat [ options[:class] ]
      else
        options[:class]
      end
    end
    classes = [ classes ,size_class(size) ].flatten.compact.join(' ')
    classes.strip unless classes.blank?
  end

  def size_class(size)
    LinkToAction.send("size_class_#{size}")
  end

  def action_icon(action, icon, icon_size)
    [ icon, icon_size ].compact.join(' ')
  end

  def link_to_action(action, object, options)
    name = options.delete(:name) || t_action(object, action)
    params = options.delete(:params) || {}
    params[:action] = action if [ :new, :edit ].include? action
    options[:class] = action_class(action, options)
    icon = options.delete(:icon) || LinkToAction.send("icon_#{action}")
    icon_size = options.delete(:icon_size) || LinkToAction.icons_size
    iilink_to action_icon(action, icon, icon_size), name, action_path(action, object, params),
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
    object = object.last if object.kind_of? Array
    model = if object.respond_to?(:model_name)
      object.model_name.human
    else
      object.class.model_name.human if object.class.respond_to?(:model_name)
    end

    t(:"helpers.link_to.#{action}", model: model)
  end
end

ActionView::Base.send :include, LinkToAction::Helpers