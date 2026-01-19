{
  packageOverrides =
    pkgs: with pkgs; {
      myPackages = pkgs.buildEnv {
        name = "my-packages";
        paths = [
          zsh
          starship
          kitty
          tmux
          tmuxp
          neovim
          ripgrep
          zoxide
          fzf
          eza
          fd
          git
          w3m
          gemini-cli
          glow
          lazygit
          jq
          bat
          docker
          luarocks
          lua
          tree-sitter
        ];
      };
    };
}
