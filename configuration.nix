# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./flatpak.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 5; # Limit configurations shown on boot menu.
  boot.plymouth.enable = true; # Enable boot logo and loading screen when booting.

  # Enable flakes.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "nixos"; # Define your hostname.

  # // KTL // (Keymap, Timezone, Locale)

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # // BASIC SERVICES //
  
  # Enable networking.
  networking.networkmanager.enable = true;

  # Enable X11 windowing system and GNOME Desktop Environment.
  services.xserver.enable = false;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Enable ratbagd for pkgs.piper
  services.ratbagd.enable = true;

  # Disable unused services.
  services.gnome.core-apps.enable = false;
  environment.gnome.excludePackages = [ pkgs.gnome-tour ];
  services.printing.enable = false;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # // PACKAGES / PROGRAMS

  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lykle = {
    isNormalUser = true;
    description = "Lykle";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" ];
    hashedPassword = "$2b$05$kJV9j8Yiptocft.1T9ycseNuMlF7heEVAflT1Y.lq0X2wihPRFRl2";
    packages = with pkgs; [
      audacity
      bitwarden
      gnome-calculator
      gnome-music
      errands
      evince
      fragments
      gimp
      gnome-connections
      gnome-extension-manager
      impression
      kdePackages.kdenlive
      lunar-client
      lutris
      obs-studio
      openconnect
      planify
      prismlauncher
      mullvad-vpn
      snapshot
      vesktop
      virt-manager
      vlc
      vscode
      yt-dlp
      zoom-us
    ];
  };

  services.flatpak.enable = true;
  programs.dconf.enable = true;
  programs.fish.enable = true;
  programs.steam.enable = true;
  programs.virt-manager.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  environment.systemPackages = with pkgs; [
  fastfetch
  ghostty
  git
  #gnome-console
  gnome-disk-utility
  gnome-text-editor
  #go
  htop
  man
  nixd
  nautilus
  neovim
  #lynx
  piper
  python3
  refine
  wget
  yazi

  # Virtualization Packages
  bridge-utils
  libvirt
  OVMF
  qemu_kvm
  qemu-utils
  ];

  # // Virtualization//

  users.groups.libvirtd.members = [ "lykle" ];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  # // MAINTENANCE //

  # Garbage Collecting
   nix.gc = {
    automatic = true;
    dates = "weekly";
    options  = "--delete-older-than +5";
  };
  nix.settings.auto-optimise-store = true;

  # Next Maintenance Commands Here.

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
