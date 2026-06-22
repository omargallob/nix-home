{ pkgs, ... }:

{
  # Required boilerplate — who and where.
  home.username = "omar";
  home.homeDirectory = "/home/omar";

  # Bumps when home-manager's defaults change in backwards-incompatible
  # ways. Set once, then leave it alone — don't bump just to "update".
  home.stateVersion = "25.05";

  # Step 1 of the learning plan: just a few packages, on purpose.
  # Add one at a time and re-run `home-manager switch` after each addition
  # so you can see exactly what each line does.
  home.packages = with pkgs; [
    jq
    ripgrep
    fzf
  ];

  # Step 2: a couple of "programs" modules. These aren't just package
  # installs — they also generate config files for you. Compare what
  # ends up in ~/.config after switching.
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
    };
  };

  programs.direnv.enable = true;

  # Lets `home-manager` manage itself as a package (so `home-manager`
  # the command stays available even before you've installed it any
  # other way).
  programs.home-manager.enable = true;
}
