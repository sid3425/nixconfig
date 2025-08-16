{ config, pkgs, ... }:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  
  programs.gamemode = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    steam
    lutris
    heroic
    winetricks
    protontricks
    protonup-qt
    gamescope       
    mangohud        
    dxvk
    wine
  ];

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      vulkan-loader
      vulkan-validation-layers
      vulkan-tools
    ];
  };
}

