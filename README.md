### Note: This project should mainly be used as a reference if you are learning how NixOS and/or the Nix package manager works. You can use it on your own systems, however I do not guarantee it will work 100% unless modifications specific to your system are made. Also, this readme is rather out of date with my older configuration, this will be updated soon.

This is my system configuration based on the [NixOS](https://nixos.org) Linux Distribution. While this configuration is specific to my use cases and my current hardware, I would suggest to change the configs based on your use cases.

# Usage
1. Download and install [NixOS](https://nixos.org/download) either on a VM or on bare metal.
2. Post-installation, download the files using the green colored Code button at the top of this page.
3. Now, extract the .zip file, and copy-paste the files in the `/etc/nixos` directory.
4. After pasting the files, make sure to edit them based on your needs.
5. Post editing, run the command `sudo nixos-rebuld switch` and once the process is completed, reboot the system.

Alternatively, the files can be downloaded using the git command line tool with the command `git clone https://www.github.com/sid3425/mynixosconfig` provided git is installed on your system.

# Features
1. Hybrid graphics with offloading support for Nvidia GPUs on laptops(Change the PCI ID's specific to your integrated and dedicated GPUs in the `amd-nvidia.nix` file. If not needed, do not use the file and remove the link from the `configuration.nix` file)
2. Sane defaults for
   - Development, with many compilers, text editors such as [Neovim](https://neovim.io/), [VSCode](https://code.visualstudio.com/) and [Kate](https://kate-editor.org/) included as well as [Podman](https://podman.io/) and [Distrobox](https://github.com/89luca89/distrobox) for containerized environments
   - Gaming with built in [Steam](https://store.steampowered.com/) and [Lutris](https://lutris.net) support
   - Security, with enabled firewall and full disk encryption(make sure to set it up while installing NixOS beforehand)
   - [VirtualBox](https://virtualbox.org) for easier VM creation
   - Privacy-respecting integration with other devices using Syncthing and KDE Connect
   - Haruna(an mpv based media player), Elisa audio player and [Spotify](https://spotify.com) for multimedia playback
   - Graphics tools like [Inkscape](https://inkscape.org), [Krita](https://krita,org/en) and [OBS Studio](https://obsproject.com) along with [Tenacity](https://tenacityaudio.org) and [Kdenlive](https://kdenlive.org/en) for audio and video editing respectively
   - Productivity tools like [Todoist](https://todoist.com), and [Librewolf](https://librewolf.net) and [Vivaldi](https://vivaldi.com) browsers integrated by default
   - And many more!

# Requirements
The NixOS Linux distribution should be installed either in a VM or on bare metal. An active internet connection is required to install both the base OS and for the configuration to apply correctly.

# References
1. [Chris Titus Tech's NixOS configuration](https://github.com/ChrisTitusTech/nixos-titus)
2. [NixOS wiki](https://nixos.wiki/)
