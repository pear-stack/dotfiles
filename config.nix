{
  packageOverrides =
    pkgs: with pkgs; {
      myPackages = pkgs.buildEnv {
        name = "my-packages";
        paths = [
          zsh
          starship
          alacritty
          tmux
          neovim
          ripgrep
          zoxide
          fzf
          fd
          git
          w3m
          glow
          lazygit
          jq
        ];
      };
    };
}
