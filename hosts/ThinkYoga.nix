{ config, pkgs, lib, ... }:

{
  imports = [
    #../common/encryptedzfs.nix
    #../common/configuration.nix
    #../common/home/leersums.nix
  ];

  # Silence ACPI "errors"  at boot shown before NixOS stage 1 output.
  # default is 4
  boot.consoleLogLevel = 3;

  # per-host settings
  networking.hostID = "793b5378"; #head -c 8 /etc/machine-id
  networking.hostName = "keoldale";

}
