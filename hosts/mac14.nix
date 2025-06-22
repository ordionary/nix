{
  username = "cupcakearmy";
  hostName = "mac14";
  platform = "aarch64-darwin";

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
    ];
    pkgs =
      pkgs: with pkgs; [
        biome
        infisical
        ffmpeg
      ];
  };
}
