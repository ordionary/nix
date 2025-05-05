{
  username = "cupcakearmy";
  hostName = "mac14";
  platform = "aarch64-darwin";

  extras = {
    casks = [
      "surfshark"
    ];
    pkgs =
      pkgs: with pkgs; [
        biome
        infisical
      ];
  };
}
