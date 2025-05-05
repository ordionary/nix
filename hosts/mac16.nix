{
  username = "niccoloborgioli";
  hostName = "mac16";
  platform = "aarch64-darwin";

  extras = {
    casks = [
      "phpstorm"
      "datagrip"
      "tailscale"
      "android-studio"
    ];
    pkgs =
      pkgs: with pkgs; [
        phrase-cli
        boundary
        awscli2
        _1password-cli
      ];
  };
}
