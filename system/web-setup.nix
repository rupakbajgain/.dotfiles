{lib, config, pkgs, ...}:

let
  freshrss_package = pkgs.freshrss;
  freshrss_pool = "freshrss";
  freshrss_url_path = "rss";
in
{

#set my own virtualHost
#copy from nixpkgs and merge
      services.nginx = {
        enable = true;
        virtualHosts.localhost = {
          # php files handling
          # this regex is mandatory because of the API
          locations."~ ^.+?\.php(/.*)?$"={
            root = "${freshrss_package}/p";
            extraConfig = ''
              fastcgi_pass unix:${config.services.phpfpm.pools.${freshrss_pool}.socket};
              fastcgi_split_path_info ^(.+\.php)(/.*)$;
              # By default, the variable PATH_INFO is not set under PHP-FPM
              # But FreshRSS API greader.php need it. If you have a “Bad Request” error, double check this var!
              # NOTE: the separate $path_info variable is required. For more details, see:
              # https://trac.nginx.org/nginx/ticket/321
              set $path_info $fastcgi_path_info;
              fastcgi_param PATH_INFO $path_info;
              include ${pkgs.nginx}/conf/fastcgi_params;
              include ${pkgs.nginx}/conf/fastcgi.conf;
            '';
          };

          locations."/" = {
            root = "${freshrss_package}/p";
            tryFiles = "$uri $uri/ index.php";
            index = "index.php index.html index.htm";
          };
        };
      };

#add services
    services.freshrss = {
      enable = true;
      baseUrl = "http://localhost";#change this to tell the base url is new
      passwordFile = pkgs.writeText "password" "secret";
      virtualHost = null;#dont setup, use previous
      pool = freshrss_pool;
      dataDir = "/srv/freshrss";
      extensions = [ pkgs.freshrss-extensions.youtube ] ++ [
        (pkgs.freshrss-extensions.buildFreshRssExtension rec {
          FreshRssExtUniqueId = "ClickableLinks";
          pname = "clickable-links";
          version = "1.01";
          src = pkgs.fetchFromGitHub {
            owner = "kapdap";
            repo = "freshrss-extensions";
            rev = "a44a25a6b8c7f298ac05b8db323bdea931e6e530";
            hash = "sha256-uWZi0sHdfDENJqjqTz5yoDZp3ViZahYI2OUgajdx4MQ=";
          };
          sourceRoot = "${src.name}/xExtension-ClickableLinks";
          meta = {
            description = "Replaces non-clickable plain text URLs found in articles with clickable HTML links.";
            homepage = "https://github.com/kapdap/freshrss-extensions/tree/master/xExtension-ClickableLinks";

          };
        })
      ];
    };
    /*
    services.rss-bridge = {
        enable = true;
        config={
          system.enabled_bridges = [ "*" ];
          FileCache = {
            enable_purge = true;
          };
        };
    };*/
}
