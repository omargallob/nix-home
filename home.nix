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
    bat
    eza
  ];

  # Step 2: a couple of "programs" modules. These aren't just package
  # installs — they also generate config files for you. Compare what
  # ends up in ~/.config after switching.
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      # No theme here — starship (below) owns the prompt instead. Running
      # both an oh-my-zsh theme and starship at once means two prompts
      # fighting over the same line.
    };
  };

  # Cross-shell prompt. programs.starship.enable generates the init snippet
  # and wires it into ~/.zshrc for you — no manual `eval "$(starship init zsh)"`.
  programs.starship.enable = true;

  programs.direnv.enable = true;

  # Shell history sync/search. Like starship/direnv, this is a full module —
  # it installs the atuin binary AND wires the zsh hook into ~/.zshrc, so it
  # doesn't need a matching entry in home.packages.
  programs.atuin.enable = true;

  # Declarative git config — generates ~/.gitconfig. No git config --global
  # needed; edit here instead, and it's version-controlled with everything
  # else.
  programs.git = {
    enable = true;
    settings = {
      user.name = "omargallob";
      user.email = "omargallob@gmail.com";
      init.defaultBranch = "main";
      pull.rebase = false;
    };
  };

  # Lets `home-manager` manage itself as a package (so `home-manager`
  # the command stays available even before you've installed it any
  # other way).
  programs.home-manager.enable = true;
}
