{
  username = "cupcakearmy";
  hostName = "mac14";
  platform = "aarch64-darwin";
  sshKey = "legba";

  extras = {
    casks = [
      "surfshark"
      "raspberry-pi-imager"
      "visual-studio-code"
      "signal"
      "discord"
      "vlc"
      "handbrake"
      "daisydisk"
      "blender"
      "bambu-studio"
    ];
    pkgs =
      pkgs: with pkgs; [
        biome
        infisical
        ffmpeg
        pulumi
      ];
  };
}
