{
  packageOverrides =
    pkgs: with pkgs; {
      myPackages = pkgs.buildEnv {
        name = "my-packages";
        paths = [
          jq
          neovim
          fd
          ripgrep
          fzf
          lazygit
        ];
      };
    };
}
