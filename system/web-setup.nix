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
          locations."~ ^/${freshrss_url_path}/.+?\.php(/.*)?$"={
            root = "${freshrss_package}/p";
            extraConfig = ''
              fastcgi_pass unix:${config.services.phpfpm.pools.${freshrss_pool}.socket};
              fastcgi_split_path_info ^/${freshrss_url_path}(/.+\.php)(/.*)?$;
              set $path_info $fastcgi_path_info;
              fastcgi_param PATH_INFO $path_info;
              fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
              include ${pkgs.nginx}/conf/fastcgi_params;
              include ${pkgs.nginx}/conf/fastcgi.conf;
            '';
          };

          locations."~ ^/${freshrss_url_path}(?!.*\.php)(/.*)?$" = {
            root = "${freshrss_package}/p";
            tryFiles = "$1 /${freshrss_url_path}$1/index.php$is_args$args";
            index = "index.php index.html index.htm";
          };

          locations."/" = {
            return = "301 /rss/";
          };
        };
      };

#add services
    services.freshrss = {
      enable = true;
      baseUrl = "http://localhost/${freshrss_url_path}";#change this to tell the base url is new
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
