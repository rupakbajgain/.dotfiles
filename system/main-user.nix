{lib, config, pkgs, ...}:

let
    cfg = config.main-user;
in
{
    options.main-user = {
        enable = lib.mkEnableOption "enable user module";
        userName = lib.mkOption {
            default = "rupak";
            description = ''
                username
            '';
        };
    };

    config = lib.mkIf cfg.enable {
        users.users.${cfg.userName} = {
            isNormalUser = true;
            initialPassword = "12345";
            description = "Rupak Bajgain";
            extraGroups = [ "networkmanager" "wheel" ];
            packages = with pkgs; [
                wget
            ];
        };
    };
}
