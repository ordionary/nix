# Dotfiles with Nix on macOS

## Installation

```bash
# Install nix [without the --determinate flag]
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

# Install brew [for casks]
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Get repo
git clone https://github.com/cupcakearmy/nix-macos ~/.config/nix-darwin

# Installation
nix run nix-darwin -- switch --flake ~/.config/nix-darwin#mbp
```

## Crypt

Files under `secrets` are encrypted using `git-crypt`.

```bash
# Save the key, when the repo is unlocked
git-crypt export-key - | base64 > .key.b64

# Decode (Given the base64 key is written to .key.b64)
cat .key.b64 | base64 --decode > .key
git-crypt unlock .key
```
