{ config, pkgs, ... }:

{
  # TODO please change the username & home directory to your own
  home.username = "bram";
  home.homeDirectory = "/home/bram";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';
  home.file."School/.keep".text = "";
  home.file."Projects/.keep".text = "";
  home.file."Download/.keep".text = "";
  home.file."Documents/.keep".text = "";
  home.file."Music/.keep".text = "";
  home.file."Pictures/.keep".text = "";

 
  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them

    # archives
    zip
    xz
    unzip
    p7zip

    # networking tools
    iperf3
    dnsutils  # `dig` + `nslookup`
    nmap # A utility for network discovery and security auditing
    

    # misc
    tree

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    # productivity
    btop  # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring

    # system tools
    ethtool
    pciutils # lspci
    usbutils # lsusb
  ];

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Bram Rodenboog";
    userEmail = "BramRodenboog@users.noreply.github.com";
  };

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 12;
        draw_bold_text_with_bright_colors = true;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    # TODO add your custom bashrc here
    
    initExtra = ''
	export PS1='\[\e[38;5;245;1m\][\[\e[38;5;43m\]\u\[\e[0m\] \[\e[38;5;43;1m\]in\[\e[0m\] \[\e[38;5;51;1m\]\w\[\e[38;5;245m\]]\[\e[38;5;244m\]\\$\[\e[0m\] '
    '';
    # set some aliases, feel free to add more or remove some
    shellAliases = {
      fu  = "cd /etc/nixos && sudo nix flake update && cd -";
      nrs = "sudo nixos-rebuild switch --flake /etc/nixos";
     
    };
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
