module LinkToAction::Utils
  def self.action_icon(action, options)
    icon = options.delete(:icon) || LinkToAction.send("icon_#{action}")
    icon_size = options.delete(:icon_size) || LinkToAction.icons_size
    icon_size = nil if icon_size == :default
    [ icon, icon_size ].compact.map {|i| "icon-#{i}"}.join(' ') unless icon == ''
  end
end