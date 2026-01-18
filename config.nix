{
  packageOverrides =
    pkgs: with pkgs; {
      myPackages = pkgs.buildEnv {
        name = "my-packages";
        paths = [
          jq
          neovim
          tmux
          zsh
          fd
          ripgrep
          zoxide
          fzf
          lazygit
        ];
      };
    };
}
