# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      #inputs.home-manager.nixosModules.default
    ];

  # Flakes.
  nix.settings.experimental-features = [ "nix-command" "flakes"];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Boot with Nix Logo.
  boot.plymouth.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;
  networking.hostName = "nixos"; # Define your hostname.

  # Enable bluetooth
  hardware.bluetooth.enable = true;

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

  # Enable the X11 windowing system.
  services.xserver.enable = false;

  # Enable the GNOME Desktop Environment and removes most core applications.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Disabled packages/services.
  services.printing.enable = false; # Disables Printing.
  services.gnome.core-apps.enable = false; # Disables Core Gnome Apps
  environment.gnome.excludePackages = with pkgs; [ # Disables Gnome Tour
    gnome-tour
  ];
  services.xserver.excludePackages = [ pkgs.xterm ]; # Disables XTerm

  # Enable Flatpak
  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target"];
    path = [pkgs.flatpak];
    script = ''
      flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    '';
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;    
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lykle = {
    isNormalUser = true;
    description = "Lykle";
    extraGroups = [ "networkmanager" "wheel" ];
    hashedPassword = "$2b$05$4mSzKCquskY9.4qGV66D7.NKfl.7qADU/jbWs9Sv3SzmtnOBQQu7m";
    packages = with pkgs; [
    librewolf
    vesktop
    steam
    lutris
    obs-studio
    prismlauncher
    fastfetch
    nautilus
    audacity
    bitwarden
    refine 
    ];
  };

  # To search, run: $ nix search wget
  environment.systemPackages = with pkgs; [
  vim
  git 
  wget
  htop
  lf
  man
  gnome-software
  gnome-console
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
  nixpkgs.config.allowUnfree = true;
 
  /* MAINTENANCE */
  
  nix.gc = {
    automatic = true; 
    options  = "--delete +10";
  };
 
  /* UNUSED */
  
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
