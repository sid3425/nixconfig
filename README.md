# Note: This project is a work in progress, this should mainly be used as a reference if you are learning how NixOS and/or the Nix package manager works. You can use it on your own systems, however I do not guarantee it will work 100% unless modifications specific to your system are made.

# My NixOS Configuration
This is my system configuration based on NixOS. While this configuration is specific to my use cases and my current hardware, I would suggest to change the configs based on your use cases.

# Features
1. Hybrid graphics support with Nvidia GPUs for laptops(Change the PCI ID's specific to your integrated and dedicated GPUs in the amd-nvidia.nix file. If not needed, do not use the file and import the link from the configuration.nix file)
2. Containerization support using podman
3. Created a full desktop experience using the KDE Plasma desktop environment
4. Fonts like JetBrains Mono and Inter included by default
5. Developer friendly(ish) ;)

# Requirements
The NixOS Linux distribution should be installed either in a VM or on bare metal.

# Usage
Just replace the default configuration.nix located at /etc/nixos/ inside NixOS and run sudo nixos-rebuild switch after making the changes in the command line.
