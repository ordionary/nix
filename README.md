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
