# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{  
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./amd-nvidia.nix
      ./podman-shell.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-7dc8106d-ab52-4860-a335-b9eac77446bc".device = "/dev/disk/by-uuid/7dc8106d-ab52-4860-a335-b9eac77446bc";
  boot.initrd.luks.devices."luks-7dc8106d-ab52-4860-a335-b9eac77446bc".keyFile = "/crypto_keyfile.bin";

  networking.hostName = "MySystem"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  services.xserver.displayManager.defaultSession = "plasmawayland";

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sid = {
    isNormalUser = true;
    description = "Siddharth Saxena";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      librewolf
      krita
      obs-studio
      inkscape
      kdenlive
      megasync
      qbittorrent
      veracrypt
      brave
      freetube
      steam
      zoom-us
      bitwarden
      vlc
      audacity
      libreoffice-qt
      libsForQt5.kclock
      libsForQt5.kate
      libsForQt5.keysmith
      libsForQt5.kalk
      popsicle
      libsForQt5.kamoso
      gparted
      libsForQt5.kalendar
    ];
  };
  
  # Enable FLatpak
  services.flatpak.enable = true;

  #Enable KDEConnect
  programs.kdeconnect.enable = true;
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  #Enable VirtualBox
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];

  #Enable auto-cpufreq for power management
  services.auto-cpufreq.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    python3
    gcc
    distrobox
    neofetch
    git
    gitRepo
    gnupg
    autoconf
    procps
    gnumake
    util-linux
    m4
    gperf
    unzip
    ncurses5
    stdenv.cc
    binutils
    zsh
    polkit
    pipx
    appimage-run
    syncthing
    syncthingtray
    android-tools
    inter
    jetbrains-mono
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
    networking.firewall = { 
    enable = true;
    allowedTCPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
    allowedUDPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
  };

  #Reduce swappiness
  boot.kernel.sysctl = { "vm.swappiness" = 10;};

  # Auto system update
  system.autoUpgrade = {
      enable = true;
  };

  # Automatic Garbage Collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 2d";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
