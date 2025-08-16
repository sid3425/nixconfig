{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    cleanFastfetch = {
      url = "github:sid3425/clean-fastfetch";
    };
  };

  outputs = { self, nixpkgs, cleanFastfetch, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations.helloworld = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          ./modules/amd-nvidia.nix
          ./modules/gaming.nix
          ./modules/flatpak.nix
	  ./modules/drive.nix
          home-manager.nixosModules.default
          {
            home-manager.users.johnwick = {
              home.stateVersion = "25.05";
              # Removed the "imports" list that caused the error.
              home.file.".config/fastfetch/config.jsonc".source = "${cleanFastfetch}/config.jsonc";
              programs.neovim = {
                enable = true;
                withNodeJs = true;
                withPython3 = true;
                extraConfig = ''
                '';
              };
              home.packages = with pkgs; [
                nerd-fonts.jetbrains-mono
                rust-analyzer
                rustc
                cargo
                bash-language-server
              ];
            };
          }
        ];
      };
    };
}
