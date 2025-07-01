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
    ];
    pkgs =
      pkgs: with pkgs; [
        mkcert
        dnsmasq
      ];
  };
}
