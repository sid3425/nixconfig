{ config, pkgs, ... }:

let
  desiredFlatpakApps = [
    "com.bitwarden.desktop"
    "io.ente.photos"
    "org.gimp.GIMP"
    "org.kde.krita"
    "org.kde.kdenlive"
    "com.obsproject.Studio"
    "org.localsend.localsend_app"
    "app.zen_browser.zen"
    "io.gitlab.librewolf-community"
    "org.fedoraproject.MediaWriter"
    "it.mijorus.gearlever"
    "org.signal.Signal"
    "com.protonvpn.www"
    "org.torproject.torbrowser-launcher"
  ];
in {

  system.activationScripts.flatpakManagement.text = ''
    # Add Flathub repo if not present
    ${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

    installedApps=$(${pkgs.flatpak}/bin/flatpak list --app --columns=application)

    # Install desired apps
    for app in ${toString desiredFlatpakApps}; do
      echo "Ensuring $app is installed"
      ${pkgs.flatpak}/bin/flatpak install flathub $app
    done

    # Clean unused runtime and extensions
    ${pkgs.flatpak}/bin/flatpak uninstall --unused

    # Update all flatpaks
    ${pkgs.flatpak}/bin/flatpak update
  '';
}

