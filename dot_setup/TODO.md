# Automation TODOs

- Move font installation to Ansible

- Install uv-based tools
  - ruff

- Integrate dconf settings
  - org.gnome.desktop.interface.color-scheme = 'prefer-dark'
  - org.gnome.desktop.interface.font-name = 'Inter Variable 11'
  - org.gnome.desktop.interface.document-font-name = 'Inter Variable 12'
  - org.gnome.desktop.interface.monospace-font-name ='GoogleSansCode Nerd Font Mono 11'
  - org.gnome.desktop.interface.show-battery-percentage = true
  - org.gnome.desktop.interface.accent-color = 'yellow'
  - org.gnome.desktop.peripherals.touchpad.click-method = 'areas'
  - org.gnome.desktop.session.idle-delay = uint32 900
  - org.gnome.desktop.screensaver.lock-delay = uint32 300
  - org.gnome.desktop.wm.preferences.button-layout = 'appmenu:minimize,maximize,close'
  - org.gnome.desktop.wm.preferences.num-workspaces 1
  - org.gnome.desktop.interface.clock-show-weekday = true
  - org.gnome.desktop.datetime.automatic-timezone = true
  - org.gnome.mutter.dynamic-workspaces = false
  - org.gnome.nautilus.preferences.default-folder-viewer = 'list-view'
  - org.gnome.desktop.notifications.show-in-lock-screen = false
  - org.gnome.shell.disabled-extensions = "['background-logo@fedorahosted.org']"
  - org.gnome.shell.favorite-apps = @as []
  - org.gnome.tweaks.show-extensions-notice = false
  - org.gtk.gtk4.settings.file-chooser.show-hidden = true

- (Maybe) Keyboard shortcuts
  - Super+Enter -> terminal
  - Super+E -> Files
