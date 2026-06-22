# nix-config — home-manager learning sandbox

A deliberately small starting point for learning Nix + home-manager on this
Raspberry Pi, before deciding whether to port the full devops-starter setup
over. Nothing in here has been applied yet — Nix isn't installed on this
machine.

## What's here

- `flake.nix` — wires up nixpkgs + home-manager, defines one machine
  (`omar@pi`, aarch64-linux — matches this Pi).
- `home.nix` — the actual config. Intentionally tiny: 3 packages (`jq`,
  `ripgrep`, `fzf`) plus zsh+oh-my-zsh and direnv. Grow this incrementally.

## Learning plan

1. **Install Nix** (multi-user daemon installer, works fine on a Pi):
   ```sh
   curl -L https://nixos.org/nix/install | sh -s -- --daemon
   ```
   Then open a new shell so the Nix environment is sourced.

2. **Enable flakes** — add to `~/.config/nix/nix.conf` (create it if it
   doesn't exist):
   ```
   experimental-features = nix-command flakes
   ```

3. **Apply this config**:
   ```sh
   cd ~/nix-config
   nix run home-manager/master -- switch --flake .#omar@pi
   ```
   First run will be slow (downloads/builds everything). Watch the output —
   it tells you exactly what it's linking into your home directory.

4. **Verify**:
   ```sh
   which jq rg fzf      # should now point into /nix/store/...
   echo $SHELL           # zsh, if you change your login shell (see below)
   ```

5. **Make one change at a time.** Add a package to `home.packages`, re-run
   the same `switch` command, see what changed. Suggested order:
   - Add `bat` and `eza` — common easy wins, immediate payoff.
   - Add `starship` and `programs.starship.enable = true;` — try it instead
     of oh-my-zsh's theme (turn `oh-my-zsh.theme` off if so, to avoid two
     prompts fighting).
   - Add `atuin` (`programs.atuin.enable = true;`) — shell history sync.
   - Try `programs.git.enable = true;` with `userName`/`userEmail` set
     declaratively instead of via `git config --global`.

6. **Learn rollback** — break something on purpose (typo a package name),
   run `switch`, watch it fail safely, then:
   ```sh
   home-manager generations          # list past generations
   home-manager switch --generation N  # roll back if needed
   ```
   This atomic-rollback behavior is the main thing home-manager buys you
   over devops-starter's imperative installs.

7. **Set zsh as your login shell** once you're happy with it:
   ```sh
   chsh -s $(which zsh)
   ```

## Not yet decided

This repo is for learning only. The decision on whether to actually retire
[devops-starter](https://github.com/omargallob/devops-starter) in favor of
home-manager — and the full tool-by-tool port — is intentionally deferred
until this sandbox feels comfortable. See the `~/nix-home-manager-draft`
directory for the fuller draft (1:1 port of devops-starter's ~80-tool
registry) once you're ready for that step.
