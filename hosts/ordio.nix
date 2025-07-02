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
      ];
  };
}
