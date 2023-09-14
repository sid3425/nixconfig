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
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    # Setup keyfile
    initrd = {
      secrets = {
        "/crypto_keyfile.bin" = null;
      };
      # Enable swap on luks
      luks.devices."luks-7dc8106d-ab52-4860-a335-b9eac77446bc" = {
        device = "/dev/disk/by-uuid/7dc8106d-ab52-4860-a335-b9eac77446bc";
        keyFile = "/crypto_keyfile.bin";
      };
    };
    # Reduce swappiness
    kernel.sysctl = { "vm.swappiness" = 10;};
  };
  
  # Enable networking and firewall
  networking = {
    hostName = "hp-pavilion-gaming";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPortRanges = [ 
      { from = 1714; to = 25000; } # 1714 to 1716 for KDE Connect and 8384 to 22000 for Syncthing
      ];  
      allowedUDPPortRanges = [ 
      { from = 1714; to = 25000; } # 1714 to 1716 for KDE Connect and 22000 to 21027 for Syncthing
      ];
    };
  };

  # Hardware services such as Bluetooth and Sound
  hardware = {
    bluetooth.enable = true;
    pulseaudio.enable = false;
  };
  sound.enable = true;
  security.rtkit.enable = true;
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
  
  # System services
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
    #Syncthing
    syncthing = {
        enable = true;
        user = "sid";
        dataDir = "/home/sid/Sync";    # Default folder for new synced folders
        configDir = "/home/sid/Sync/.config/syncthing";   # Folder for Syncthing's settings and keys
    };
    #Auto-CPUFreq for power management on Laptops
    auto-cpufreq.enable = true;
  };
  programs.dconf.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sid = {
    isNormalUser = true;
    description = "Siddharth Saxena";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      #Internet and Media
      librewolf
      vivaldi
      spotify
      discord
      telegram-desktop
      signal-desktop
      zoom-us
      megasync
      qbittorrent
      todoist-electron
      bitwarden
      #Graphics, Media and Editing
      krita
      obs-studio
      kdenlive
      tenacity
      inkscape
      haruna
      #Tools
      veracrypt
      vivaldi-ffmpeg-codecs
      libreoffice-qt
      libsForQt5.kclock
      libsForQt5.kalk
      popsicle
      libsForQt5.plasma-browser-integration
      libsForQt5.kwrited
      libsForQt5.kate
      appimage-run
      #Gaming
      steam
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
    android-tools
    syncthing
    syncthing-tray
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

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system = {
    copySystemConfiguration = true;
    autoUpgrade.enable = true;
    stateVersion = "23.05"; # Defines whether the base is based on the point releases or the unstable release
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 2d";
  };

}
