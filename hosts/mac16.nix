{
  username = "niccoloborgioli";
  hostName = "mac16";
  platform = "aarch64-darwin";

  extras = {
    casks = [
      "phpstorm"
      "datagrip"
      "tailscale"
    ];
    pkgs =
      pkgs: with pkgs; [
        vault
        cocoapods
        phrase-cli
        boundary
        awscli2
      ];
  };
}
