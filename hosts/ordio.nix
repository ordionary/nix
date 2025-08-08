{
  username = "nicco";
  hostName = "ordio";
  platform = "aarch64-darwin";
  sshKey = "ordio";

  extras = {
    casks = [
      "tableplus"
      "http-toolkit"
      "phpstorm"
      "notion"
    ];
    pkgs =
      pkgs: with pkgs; [
        mkcert
        dnsmasq
        awscli2
        mysql84
        cocoapods
        xcodes

        # For projects
        pixman
        pkg-config
        pango
        libpng
        giflib
        librsvg
        python313Packages.setuptools
      ];
  };
}
