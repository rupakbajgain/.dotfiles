{lib, config, pkgs, ...}:
{
    services.freshrss = {
      enable = true;
      baseUrl = "http://localhost";
      passwordFile = pkgs.writeText "password" "secret";
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
    #services.rss-bridge = {
    #    enable = true;
    #};
}
