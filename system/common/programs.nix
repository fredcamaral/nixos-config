{
  lib,
  pkgs,
  ...
}: {
  programs = {
    zsh.enable = true;
    dconf.enable = true;

    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
  };

  # Thunar settings
  environment.etc."xdg/Thunar/uca.xml".text = ''
    <?xml version="1.0" encoding="UTF-8"?>
    <actions>
      <action>
        <icon>utilities-terminal</icon>
        <name>Open Terminal Here</name>
        <unique-id>1653915407085961-1</unique-id>
        <command>exo-open --working-directory %f --launch TerminalEmulator</command>
        <description>Open Terminal in Current Directory</description>
        <patterns>*</patterns>
        <startup-notify/>
        <directories/>
      </action>
      <!-- Add more custom actions here -->
    </actions>
  '';

  # Additional Thunar configurations
  environment.etc."xdg/xfce4/xfconf/xfce-perchannel-xml/thunar.xml".text = ''
    <?xml version="1.0" encoding="UTF-8"?>
    <channel name="thunar" version="1.0">
      <property name="last-view" type="string" value="ThunarIconView"/>
      <property name="last-icon-view-zoom-level" type="string" value="THUNAR_ZOOM_LEVEL_100_PERCENT"/>
      <property name="last-window-width" type="int" value="640"/>
      <property name="last-window-height" type="int" value="480"/>
      <property name="last-window-maximized" type="bool" value="false"/>
      <property name="last-separator-position" type="int" value="170"/>
      <property name="misc-single-click" type="bool" value="false"/>
      <property name="misc-thumbnail-mode" type="string" value="THUNAR_THUMBNAIL_MODE_ALWAYS"/>
      <property name="shortcuts-icon-size" type="string" value="THUNAR_ICON_SIZE_SMALLER"/>
      <property name="tree-icon-size" type="string" value="THUNAR_ICON_SIZE_SMALLEST"/>
    </channel>
  '';
}
