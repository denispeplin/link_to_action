module LinkToAction::Utils
  def self.action_icon(action, options)
    icon = options.delete(:icon) || LinkToAction.send("icon_#{action}")
    icon_size = options.delete(:icon_size) || LinkToAction.icons_size
    icon_size = nil if icon_size == :default
    [ icon, icon_size ].compact.map {|i| "icon-#{i}"}.join(' ') unless icon == ''
  end

  def self.add_icon_to_name(icon, name, options)
    icon_swap = options.delete(:icon_swap)
    if LinkToAction.use_icons && icon
      icon = "<i class=\"#{icon}\"></i>"
      name = [icon, ERB::Util.html_escape(name) ]
      name.reverse! unless LinkToAction.icons_place_left
      name.reverse! if icon_swap
      name.join(' ').html_safe
    else
      name
    end
  end

  def self.action_class(action, options)
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
    size_class =  [ LinkToAction.send("size_class_#{size}") ]
    classes = classes.concat(size_class).compact.join(' ')
    classes unless classes.blank?
  end
  
  # TODO: inspect some advanced I18n
  # actionpack/lib/action_view/helpers/form_helper.rb, submit_default_value
  def self.t_action(object, action)
    object = object.last if object.kind_of? Array
    model = if object.respond_to?(:model_name)
      object.model_name.human
    else
      object.class.model_name.human if object.class.respond_to?(:model_name)
    end
    
    model = model.pluralize if action == :index

    I18n.t(:"helpers.link_to.#{action}", model: model)
  end
end