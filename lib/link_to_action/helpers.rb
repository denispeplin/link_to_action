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
    ilink_to 'undo large', t(:'helpers.link_to.back'), :back, options
  end

  private

  ICONS = {new: 'plus', edit: 'edit', destroy: 'trash'}

  def link_to_action(action, object, options)
    name = options.delete(:name) || t_action(object, action)
    params = options.delete(:params) || {}
    params[:action] = action if [ :new, :edit ].include? action
    ilink_to "#{LinkToAction::Helpers::ICONS[action]} large", name,
      polymorphic_path(object, params), options if cancan?(action, object)
  end

  def cancan?(*args)
    LinkToAction.use_cancan ? can?(*args) : true
  end

  def ilink_to(*args)
    name = args[1]
    if LinkToAction.use_icons
      icon = args[0].split(' ').map {|i| "icon-#{i}"}.join(' ')
      name = raw("#{icon} #{ERB::Util.html_escape(name)}")
    end
    options = args.from(2)
    link_to name, options
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

ActionView::Base.send :include, LinkToAction::Helpers