{lib, config, pkgs, ...}:
{
    services.freshrss = {
      enable = true;
      baseUrl = "http://localhost";
      passwordFile = pkgs.writeText "password" "secret";
      dataDir = "/srv/freshrss";
      extensions = [ pkgs.freshrss-extensions.youtube ];
    };
    #services.rss-bridge = {
    #    enable = true;
    #};
}
