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
        vault
        cocoapods
        phrase-cli
        boundary
        awscli2
        fastlane
        jdk
        android-tools
        sdkmanager
        _1password-cli
      ];
  };
}
