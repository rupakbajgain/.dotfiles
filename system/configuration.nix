{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "nixos"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kathmandu";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = false;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.rupak = {
    isNormalUser = true;
    description = "Rupak Bajgain";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      wget
    #  kdePackages.kate
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  security.sudo.extraRules = [{
    users = ["rupak"];
    commands = [{
      command = "ALL";
      options=["NOPASSWD"];
    }];
  }];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
   vim
   git
   lutris
   kdePackages.discover
   distrobox
   podman
  ];

  # List services that you want to enable:
  services.flatpak.enable=true;
  xdg.portal.enable=true;


  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # First install, leave it as it is
  system.stateVersion = "24.05";

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport=true;
    driSupport32Bit=true;
  };

  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia.modesetting.enable = true;

  hardware.nvidia.prime = {
    sync.enable = true;
    #offload = {
    #  enable = true;
    #  enableOffloadCmd = true;
    #};


    # integrated
    amdgpuBusId = "PCI:5:0:0";
    # intelBusId = "PCI:0:0:0";

    # dedicated
    nvidiaBusId = "PCI:1:0:0";
  };

  programs.steam.enable = true;

}
