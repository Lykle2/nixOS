{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "lykle";
  home.homeDirectory = "/home/lykle";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true; # Enable home manager.
 
  # Install GNOME extensions.
  home.packages = with pkgs; [
    gnomeExtensions.appindicator # EXTENSIONS INSTALL HERE; name of extension can be found on source code url. for example, "https://github.com/ubuntu/gnome-shell-extension-appindicator" would translate to gnomeExtensions.appindicator since it's the only thing after the gnome-shell-extension part.
    ];

  imports = 
  [
    ./browser.nix # import browser configuration for Librewolf; if you have a different browser/configuration/file-name for config file, then correct it on this line.
  ];


  # GNOME Dark Mode, Default Apps, and Tray Icons Enable. Modify dconf settings.
  dconf = {
    enable = true;
    settings = {
      # GNOME Extensions
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = [ # EXTENSIONS ENABLE HERE; Extension Manager package is used to find the email/ID for specific extensions, but other methods may be more efficient/easier.
            "appindicatorsupport@rgcjonas.gmail.com" # Tray Icons Extension.
          ];
        };
      # GNOME Theming
      "org/gnome/desktop/interface" = { # Dark Mode by Default
      color-scheme = "prefer-dark";
      };
      "org/gnome/desktop/background" = { # Wallpapers
      picture-uri = "file:///home/lykle/Pictures/Backgrounds/wallpaper-light.jpg";  # "/run/current-system/sw/share/backgrounds/gnome/" is where default GNOME Wallpapers are located.
      picture-uri-dark = "file:///home/lykle/Pictures/Backgrounds/wallpaper-dark.jpg";  # in "/run/current-system/sw/share/backgrounds/gnome/", there are light and dark mode versions of various wallpapers, be sure to set both to avoid theming issues.
      };
      "org/gnome/desktop/screensaver" = { # Screensavers
      picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/adwaita-d.jpg";
      primary-color = "#3465a4";
      secondary-color = "#000000";
      };
      # GNOME Default Dash Layout
      "org/gnome/shell" = { # Apps to show up in your dash in GNOME Overview.
        favorite-apps = [ # .desktop files can be found in "/run/current-system/sw/share/applications/".
	"librewolf.desktop"
	"vesktop.desktop"
	"bitwarden.desktop"
	"steam.desktop"
	"net.lutris.Lutris.desktop" 
	"org.prismlauncher.PrismLauncher.desktop" 
	"com.obsproject.Studio.desktop" 
	"audacity.desktop"
	"org.kde.kdenlive.desktop"
	"org.gnome.Nautilus.desktop"
	"com.mitchellh.ghostty.desktop"
	];
      };

# GNOME Hotkeys -- WORK IN PROGRESS -- NOT ADVISABLE TO COPY YET -- dconf editor can be used to modify/gather information on dconf settings if you know what you're doing.

  "org/gnome/settings-daemon/plugins/media-keys" = {
    volume-mute = [ "<Shift>KP_Subtract" ];
    mic-mute = [ "<Shift>KP_Add" ];
    switch-applications = [ "<Alt>Tab" ];
    switch-applications-backward = [ "<Shift><Alt>Tab" ];
    };
  };
};
# Global Cursor -- Set global cursor theme for apps that don't natively respect it. (such as the steam nixpkg)
  home = {
    pointerCursor = {
      package = pkgs.adwaita-icon-theme;
      gtk.enable = true;
      name = "Adwaita";
      size = 32;
    };
  };
}
