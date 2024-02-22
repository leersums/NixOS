{ config, pkgs, lib, ... }:

{
  imports = [
    #../common/encryptedzfs.nix
    #../common/configuration.nix
    #../common/home/leersums.nix
  ];

# Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware = {
     opengl.enable = true;
     nvidia.modesetting.enable = true;
  };

# Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

# Silence ACPI "errors"  at boot shown before NixOS stage 1 output.
# default is 4
  boot.consoleLogLevel = 3;

# per-host settings
  systemd.network.netdevs.wlp4s0.matchConfig =
  {
    MACAddress = "ac:7b:a1:96:02:1c";
    Type = "wlan";
  };
  networking = {
    hostId = "793b5378"; #head -c 8 /etc/machine-id
    hostName = "keoldale";
    interfaces."wlp4s0".useDHCP = true;
    wireless = {
      enable = true;
      userControlled.enable = true;
      interfaces = [ "wlp4s0" ];
      networks = {
        "GalaxyInternet" = {
           psk = "wewd7687";
        };

        "LotjeAanDeLindelaan" = { 
           #pskRaw="67ed7b21a609f1cc518aa540605106b6e994ab70663a51ae16382a175a06343d";
           psk="41052409825673181655";
           priority = 1;
         };

         "FRITZ sagittarius" = {
           psk="Rl28115!";
         };

         FreeWiFi = {};

         "Hoylake" = {
           pskRaw="0791410e88762869286eee04b39616a13114bb602692c8ba1da75df456813837";
         };

         "App_Vacances" = {
           psk="jomini-baulet3";
         };
       };
    };
  };
}
