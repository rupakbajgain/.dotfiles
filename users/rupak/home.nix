{ config, pkgs, ... }:

{
  home.username = "rupak";
  home.homeDirectory = "/home/rupak";

  # Leave it as it is
  home.stateVersion = "24.05";

  programs.gpg.enable=true;
  services.gpg-agent = {
    enable=true;
    pinentryPackage=pkgs.pinentry-qt;
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    git-crypt
    gnupg
    pinentry-qt
    bash-completion
    bat
    tree
    unzip
    fontconfig
    starship
    zoxide
    fastfetch
  ];

  home.file.".local/share/fonts/Meslo/MesloLGSNerdFontMono-Regular.ttf" = {
    source = ./MesloLGSNerdFontMono-Regular.ttf;
  };
  home.file.".bashrc"={source=./mybash/bashrc;};
  home.file.".config/starship.toml"={source=./mybash/starship.toml;};
  home.file.".config/fastfetch/config.jsonc"={source=./mybash/config.jsonc;};
  home.file.".config/distrobox/distrobox.conf"={source=./distrobox.rc;};

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.git={
    enable=true;#install in user too to save these informations
    userName="Rupak Bajgain";
    userEmail="bajgainrupakb@gmail.com";
    extraConfig.init.defaultBranch = "main";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
