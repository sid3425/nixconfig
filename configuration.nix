{ config, pkgs, lib, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernel.sysctl = { "vm.swappiness" = 10;};
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "apparmor=1" ];
  };

  security = {
    apparmor.enable = true;
    rtkit.enable = true;
    lsm = [ "apparmor" ];
  };

  hardware.bluetooth = {
  enable = true;
  powerOnBoot = true;
  settings = {
    General = {
      Experimental = true; # Show battery charge of Bluetooth devices
      };
    };
  };

  networking = {
    hostName = "helloworld";
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
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services = {
    gvfs.enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
    xserver = {
      xkb = {
        layout = "us";
        variant = "";
      };
    };
    libinput.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };
    printing.enable = true;
    udev.packages = with pkgs; [ pkgs.gnome-settings-daemon ];
    dbus.packages = [ pkgs.libsForQt5.kpmcore ];
    flatpak.enable = true;
  };
  programs = {
    appimage.enable = true;
    appimage.binfmt = true;
    dconf.enable = true;
    kdeconnect.enable = true;
    partition-manager.enable = true;
    java.enable = true;
    firefox.enable = true;
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
      ];
    };
  };

  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.config.common.default = "gtk";

  users = {
    users.johnwick = {
      isNormalUser = true;
      description = "JohnWick";
      extraGroups = [ "networkmanager" "wheel" "vboxusers" ];
      packages = with pkgs; [
        kdePackages.kate
        brave
	qbittorrent
	libreoffice-qt
	appimage-run
	vlc
      ];
    };
    extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs; };
    users = {
      "johnwick" = import ./home-manager/home.nix;
    };
  };

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

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    neovim
    wget
    distrobox
    curl
    util-linux
    android-tools
    fastfetch
    apparmor-utils
    apparmor-bin-utils
  ];

  system = {
    stateVersion = "25.05";
    autoUpgrade.enable = true;
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 2d";
  };
}
