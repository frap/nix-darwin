{ config, pkgs, ... }:

{

# List packages installed in system profile. To search by name, run:
# $ nix-env -qaP | grep wget
environment.systemPackages =
  [ pkgs.ansible
    pkgs.atuin
    pkgs.awscli2
    pkgs.babashka
    pkgs.bat
    pkgs.bbin
    pkgs.clj-kondo
    pkgs.cljfmt
    pkgs.clojure
    pkgs.clojure-lsp
    pkgs.coreutils
    pkgs.delta
    pkgs.devenv
    pkgs.dig
    pkgs.eza
    pkgs.fd
    pkgs.fzf
    pkgs.gh
    pkgs.git
    pkgs.gnupg
    pkgs.gnused
    pkgs.granted
    pkgs.hunspell
    pkgs.hunspellDicts.en_NZ
    pkgs.hunspellDicts.es_ES
    pkgs.hunspellDicts.fr-moderne
    pkgs.jet
    pkgs.jq
    pkgs.neil
    pkgs.opentofu
    pkgs.plantuml
    pkgs.podman
    pkgs.podman-compose
    pkgs.ripgrep
    pkgs.rsync
    pkgs.ruff
    pkgs.starship
    pkgs.socat
    pkgs.temurin-bin-25
    pkgs.tflint
    pkgs.terraform-ls
    pkgs.texliveFull
    pkgs.tlrc
    pkgs.tree
    pkgs.uv
    pkgs.zellij
    pkgs.zig
    pkgs.zoxide
        ];

 # Auto upgrade nix package and the daemon service.
 # services.nix-daemon.enable = true;
  nix = {
    package = pkgs.nix;
    settings = {
      "extra-experimental-features" = [ "nix-command" "flakes" ];
      trusted-users = [ "@admin" ];
    };

   linux-builder = {
          enable = true;
          ephemeral = true;
          maxJobs = 6;
          config = {
            virtualisation = {
               darwin-builder = {
                  diskSize = 40 * 1024;
                  memorySize = 12 * 1024;
                  };
            cores = 4;
             };
          };
        };
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs = {
    # gnupg.agent.enable = true;
    zsh.enable = true;  # default shell on catalina
  };

  # Set Git commit hash for darwin-version.
 #system.configurationRevision = self.rev or self.dirtyRev or null;

 # Used for backwards compatibility, please read the changelog before changing.
 # $ darwin-rebuild changelog
 system.stateVersion = 6;

 # Install fonts
fonts.packages = [
    pkgs.aporetic
    # pkgs.atkinson-hyperlegible
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.hasklug
    pkgs.nerd-fonts.hack
    pkgs.nerd-fonts.inconsolata  
    pkgs.nerd-fonts.iosevka
    pkgs.nerd-fonts.iosevka-term
    pkgs.nerd-fonts.roboto-mono
    pkgs.nerd-fonts.space-mono
  ];

  # set some OSX preferences that I always end up hunting down and changing.
  system = {
     primaryUser = "frap";
     defaults = {
    
     # minimal dock
       dock = {
         autohide = true;
         autohide-delay = 0.24;
         orientation = "bottom";
         magnification = true;
         mru-spaces = true; 
         mouse-over-hilite-stack = true;
         show-process-indicators = false;
         show-recents = false;
         static-only = true;
         wvous-br-corner = 5;  # start screensaver
         };

       trackpad = {
        Clicking = true;
        TrackpadRightClick = true;
      };
      # a finder that tells me what I want to know and lets me work
       finder = {
         AppleShowAllExtensions = true;
         FXDefaultSearchScope   = "SCcf";
         FXPreferredViewStyle = "clmv";
         ShowPathbar = true;
         FXEnableExtensionChangeWarning = false;
         };
      # Tab between form controls and F-row that behaves as F1-F12
       NSGlobalDomain = {
         AppleKeyboardUIMode = 3;
         "com.apple.keyboard.fnState" = true;
         NSAutomaticWindowAnimationsEnabled = false;
         NSWindowShouldDragOnGesture = true;
         };

       loginwindow.LoginwindowText = "frap.tuatara";
       screencapture.location = "~/Pictures/screenshots";
       screensaver.askForPasswordDelay = 10;
     };
     
     keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
      };
  };

 security.pam.services.sudo_local.touchIdAuth = true;
}
