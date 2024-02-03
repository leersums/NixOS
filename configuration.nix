# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "keoldale"; # Define your hostname.

  # Pick only one of the below networking options.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.wireless.userControlled.enable = true;
  networking.wireless.networks = {
    LotjeAanDeLindelaan = { 
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

  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # console = {
  #  font = "Lat2-Terminus16";
  #   = "us";
  #  useXkbConfig = true; # use xkbOptions in tty.
  # };

  #Nixos enabling Flakes
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  #Allow unfree Packages
  nixpkgs.config.allowUnfree = true;

  #system.autoUpgrade.enable = true;
  #system.autoUpgrade.allowReboot = false;

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
    };
    supportedLocales = ["en_US.UTF-8/UTF-8"];
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.displayManager.defaultSession = "plasmawayland";
  programs.hyprland = {
    enable = true;
    xwayland = { 
      enable = true;
    };
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORSS = "1";


  hardware = {
     opengl.enable = true;
     nvidia.modesetting.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [xdg-desktop-portal-gtk xdg-desktop-portal-hyprland];
  };

  #fonts.enableDefaultPackages = true;
  #fonts.fontDir.enable = true;
  #fonts.packages = with pkgs; [
  #  noto-fonts
  #  noto-fonts-cjk
  #  noto-fonts-emoji
  #  liberation_ttf
  #  libertine
  #  fira-code
  #  fira-code-symbols
  #  #mplus-outline-fonts.githubRelease
  #  dina-font
  #  proggyfonts
  #  font-awesome
  #];

  # Configure keymap in X11
  services.xserver.layout = "us";
  services.xserver.xkbVariant = " ";
  # services.xserver.xkbOptions = "eurosign:e,caps:escape";

  # enable ssh server
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "no";
  services.openssh.extraConfig = "AllowUsers leersums";

  #enable teamviewer services
  services.teamviewer.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = with pkgs; [
     hplip
  ];

  # Enable GVFS
  services.gvfs.enable = true;

  #Virtualisation
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

  #Enable the use of document scanners 
  hardware.sane.enable = true;
  hardware.sane.extraBackends = [ pkgs.hplipWithPlugin ];  

  # Enable sound.
  #sound.enable = true;
  security.rtkit.enable = true;
  #hardware.pulseaudio.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  #enable openrazer support
  hardware.openrazer.enable = true;
  hardware.openrazer.mouseBatteryNotifier = true;
  hardware.openrazer.users = [ "leersums" ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.leersums = {
     isNormalUser = true;
     home = "/home/leersums";
     initialPassword = "P@ssw0rd!";
     description = "Sjoerd";
     extraGroups = [ "wheel" "dailout" "openrazer" "cdrom" "libvirtd" ]; # Enable ‘sudo’ for the user.
     # openssh.authorizedKeys.keys = ["..."];
   };

  #home-manager.users.leersums = { pkgs, ... }: {
  #   home.stateVersion = "23.05";
  #   home.packages = with pkgs; [ kicad thunderbird kile ];
  #   programs.bash.enable = true;
  #   dconf.settings = {
  #     "org/virt-manager/virt-manager/connections" = {
  #       autoconnect = ["qemu:///system"];
  #       uris = ["qemu:///system"];
  #       };
  #   };
  #};

  users.users.leersumta = {
     isNormalUser = true;
     home = "/home/leersumta";
     initialPassword = "P@ssw0rd!";
     description = "Thomas";
     extraGroups = [ "dialout" "openrazer" ];
  };

 #home-manager.users.leersumta = { pkgs, ... }: {
 #    home.stateVersion = "23.05";
 #    home.packages = with pkgs; [ thunderbird gcompris];
 #    programs.bash.enable = true;
 # };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     vim
     wget
     xfce.xfce4-terminal
     xfce.thunar
     xfce.thunar-volman
     thunderbird
     firefox
     filezilla
     mindforger
     freemind
     joplin-desktop
     gimp-with-plugins
     waybar
     wlroots
     (waybar.overrideAttrs (oldAttrs: {
         mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
          })
     )
     polkit
     btop
     dunst
     libnotify
     pavucontrol
     swww
     rofi-wayland
     usbutils
     brasero
     virt-manager-qt
     virt-manager
     zoom-us
     thunderbird
     kile
     libreoffice-qt
     texlive.combined.scheme-full
      ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  #programs.gnupg.agent = {
  #   enable = false;
  #   pinentryFlavor = "curses";
  #   enableSSHSupport = true;
  #};

  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    config.credential.helper = "libsecret";
  };

  # don't install documentation i don't use
  documentation.enable = true; # documentation of packages
  documentation.nixos.enable = false; # nixos documentation
  documentation.man.enable = true; # manual pages and the man command
  documentation.info.enable = false; # info pages and the info command
  documentation.doc.enable = false; # documentation distributed in packages' /share/doc


  # List services that you want to enable:

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}

