module LinkToAction::Utils
  def self.action_icon(action, options)
    icon = options.delete(:icon) || LinkToAction.send("icon_#{action}")
    icon_size = options.delete(:icon_size) || LinkToAction.icons_size
    icon_size = nil if icon_size == :default
    [ icon, icon_size ].compact.map {|i| "icon-#{i}"}.join(' ') unless icon == ''
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
end