### Note: This project is under relatively constant modifications, this should mainly be used as a reference if you are learning how NixOS and/or the Nix package manager works. You can use it on your own systems, however I do not guarantee it will work 100% unless modifications specific to your system are made.

This is my system configuration based on the [NixOS](https://nixos.org) Linux Distribution. While this configuration is specific to my use cases and my current hardware, I would suggest to change the configs based on your use cases.

# Usage
1. Download and install [NixOS](https://nixos.org/download) either on a VM or on bare metal.
2. Post-installation, download the files using the green colored Code button at the top of this page.
3. Now, extract the .zip file, and copy-paste the files in the `/etc/nixos` directory.
4. After pasting the files, make sure to edit them based on your needs.
5. Post editing, run the command `sudo nixos-rebuld switch` and once the process is completed, reboot the system.

Alternatively, the files can be downloaded using the git command line tool with the command `git clone https://www.github.com/sid3425/mynixosconfig` provided git is installed on your system.

# Features
1. Hybrid graphics support with Nvidia GPUs for laptops(Change the PCI ID's specific to your integrated and dedicated GPUs in the `amd-nvidia.nix` file. If not needed, do not use the file and remove the link from the `configuration.nix` file)
2. Containerization support using [Podman](https://docs.podman.io/en/latest/) and [Distrobox](https://github.com/89luca89/distrobox)
3. Created a full desktop experience using the KDE Plasma desktop environment
4. Developer friendly(ish) with packages such as gcc, python3, pip, git etc. are included ;)
5. Support for newer Linux-focused technologies such as Flatpak and Wayland enabled by default
6. Enabled firewall for overall better system security.
7. Built in support for KDE Connect and Syncthing for better integration with other devices while respecting the user's privacy.
8. Built in virtual machine support using VirtualBox for easy deployement of virtual machines.

# Requirements
The NixOS Linux distribution should be installed either in a VM or on bare metal. An active internet connection is required to install both the base OS and for the configuration to apply correctly.
