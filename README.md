# Note: This project is a work in progress, this should mainly be used as a reference if you are learning how NixOS and/or the Nix package manager works. You can use it on your own systems, however I do not guarantee it will work 100% unless modifications specific to your system are made.

This is my system configuration based on the NixOS Linux Distribution. While this configuration is specific to my use cases and my current hardware, I would suggest to change the configs based on your use cases.

# Usage
1. Download and install [NixOS](https://nixos.org/download) either on a VM or on bare metal.
2. Post-installation, download the files using the green colored Code button at the top of this page.
3. Now, extract the .zip file, and copy-paste the files in the ''' /etc/nixos ''' directory.
4. After pasting the files, make sure to edit them based on your needs.
5. Post editing, run the command ''' sudo nixos-rebuild switch ''' and once the process is completed, reboot the system.


# Features
1. Hybrid graphics support with Nvidia GPUs for laptops(Change the PCI ID's specific to your integrated and dedicated GPUs in the ''' amd-nvidia.nix ''' file. If not needed, do not use the file and remove the link from the ''' configuration.nix ''' file)
2. Containerization support using [Podman](https://docs.podman.io/en/latest/) (make sure to add the '''podman.nix''' file to the ''' /etc/nixos directory ''' as well)
3. Created a full desktop experience using the KDE Plasma desktop environment
4. Fonts such as JetBrains Mono(for the command line) and Inter(for the GUI) are included by default
5. Developer friendly(ish) with packages such as gcc, python3, pip, git etc. included by default ;)
6. Flatpak and VirtualBox support enabled by default
7. Firewall enabled by default for overall better system security, with ports allowed for applications such as KDE Connect.

# Requirements
The NixOS Linux distribution should be installed either in a VM or on bare metal. An active internet connection is required to install both the base OS and for the configuration to apply correctly.
