{ config, pkgs, ... }:

{
  home = {
    username = "johnwick";
    homeDirectory = "/home/johnwick";
    stateVersion = "25.05"; 
    packages = [
    ];
    file = {
    };
    sessionVariables = {
    };
  };

  imports = [
  ];

  programs.home-manager.enable = true;
}
