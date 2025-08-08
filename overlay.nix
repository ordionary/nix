final: prev: {
  nvs = prev.buildGoModule rec {
    pname = "nvs";
    version = "1.10.5";

    src = prev.fetchFromGitHub {
      owner = "cupcakearmy";
      repo = pname;
      # tag = "v${version}";
      rev = "1700f2751e969b77b7f7ab3cc16a4e0f3955ce14";
      sha256 = "sha256-RScXYxkrfLJp1nAgN2YgSRC4mLGK4yXsYjGBrDR00b8=";
    };

    vendorHash = "sha256-l2FdnXA+vKVRekcIKt1R+MxppraTsmo0b/B7RNqnxjA=";

    # Completions
    nativeBuildInputs = [ prev.installShellFiles ];
    postInstall = ''
      export HOME=$TMPDIR
      installShellCompletion --cmd nvs \
        --bash <($out/bin/nvs completion bash) \
        --fish <($out/bin/nvs completion fish) \
        --zsh <($out/bin/nvs completion zsh)
    '';

  };
}
