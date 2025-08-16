{ config, lib, pkgs, ... }:

{
  fileSystems."/mnt/Data" = {
    device = "/dev/disk/by-label/Data";
    fsType = "ext4";  # e.g., ext4, ntfs, exfat
    options = [ "defaults" "nofail" ];
  };

  systemd.tmpfiles.rules = [
    "d /mnt/Data 0777 root root -"
  ];

  # Adjust permissions after mount
  systemd.services."fix-mnt-Data-perms" = {
    description = "Fix permissions on /mnt/Data after mount";
    after = [ "local-fs.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.coreutils}/bin/chmod 0777 /mnt/Data";
    };
  };
}

