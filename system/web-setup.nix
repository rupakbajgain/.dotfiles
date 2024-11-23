{lib, config, pkgs, ...}:
{

  # Nginx configuration
  services.nginx = {
    enable = true;
    virtualHosts."127.0.0.1" = {
      root = "/var/www/site-1/";

      };
    };

    # installation and configuration script
    system.activationScripts = {
      installNginx = ''
      mkdir -p /var/www/site-1 #
      chown -R nginx:nginx /var/www/site-1

      # Create the index.html file and add the content
       cat <<EOF > /var/www/site-1/index.html
<html>
<head>
</head>
<body>
<center>
<h1> IT WORKS! </h1>
</center>
</body>
</html>
EOF

     chown nginx:nginx /var/www/site-1/index.html
      '';
      };

}
