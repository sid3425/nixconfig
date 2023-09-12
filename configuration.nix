# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{  
  imports =
    [
      ./hardware-configuration.nix
      ./amd-nvidia.nix
    ];

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  
  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-7dc8106d-ab52-4860-a335-b9eac77446bc".device = "/dev/disk/by-uuid/7dc8106d-ab52-4860-a335-b9eac77446bc";
  boot.initrd.luks.devices."luks-7dc8106d-ab52-4860-a335-b9eac77446bc".keyFile = "/crypto_keyfile.bin";

  # Enable networking and firewall
  networking = {
    hostName = "hp-pavilion-gaming";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
      ];  
      allowedUDPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
      ];
    };
  };
  hardware.bluetooth.enable = true;
  systemd.services.NetworkManager-wait-online.enable = false;

  # Select internationalisation properties.
  time.timeZone = "Asia/Kolkata";
  i18n = {
    defaultLocale = "en_IN";
    extraLocaleSettings = {
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
  };

  services = {
    xserver = {
      enable = true;
      displayManager.sddm.enable = true;
      desktopManager.plasma5.enable = true;
      displayManager.defaultSession = "plasmawayland";
      layout = "us";
      xkbVariant = "";
      libinput.enable = true;
    };
    #Audio
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };
    #Printing
    printing.enable = true;
    #Udev Packages
    udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
    #DBus packages
    dbus.packages = [ pkgs.libsForQt5.kpmcore ];
    #Flatpak
    flatpak.enable = true;
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sid = {
    isNormalUser = true;
    description = "Siddharth Saxena";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      librewolf
      krita
      obs-studio
      kdenlive
      megasync
      qbittorrent
      veracrypt
      steam
      bitwarden
      haruna
      tenacity
      libreoffice-qt
      libsForQt5.kclock
      libsForQt5.kalk
      popsicle
      libsForQt5.plasma-browser-integration
      vivaldi
      vivaldi-ffmpeg-codecs
      gparted
    ];
  };
  programs = {
    kdeconnect.enable = true;
    partition-manager.enable = true;
  };
  nixpkgs.config.allowUnfree = true;
  users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    virtualbox = {
      host.enable = true;
    };
  };

  #Enable auto-cpufreq for power management
  services.auto-cpufreq.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
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

  #Reduce swappiness
  boot.kernel.sysctl = { "vm.swappiness" = 10;};

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system = {
    copySystemConfiguration = true;
    autoUpgrade.enable = true;
  };
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
