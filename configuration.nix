{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./home-kris.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot"; # ← use the same mount point here.
    };
    grub = {
       enable = true;
       efiSupport = true;
       useOSProber = true;
       #efiInstallAsRemovable = true; # in case canTouchEfiVariables doesn't work for your system
       device = "nodev"; # EFI only
       configurationLimit = 5;
    };
  };
  
  networking = {
    hostName = "nixos"; # Define your hostname.

    # Pick only one of the below networking options.
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    # networkmanager.enable = true;  # Easiest to use and most distros use this by default.
    
    # Use IWD instead
    # wireless.iwd.enable = true; # conflicts with wireless.enable
    # networkmanager.wifi.backend = "iwd";

    # Configure network proxy if necessary
    # proxy = {
      # proxy.default = "http://user:password@proxy:port/";
      # noProxy = "127.0.0.1,localhost,internal.domain";
    # };
    # firewall = {
      # enable = false; # disable firewall
      # firewall.allowedTCPPorts = [ ... ];
      # allowedUDPPorts = [ ... ];
    # };
  }; 
  

  # Set your time zone.
   time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # Services
  services = {
    # Enable CUPS to print documents.
    # printing.enable = true;

    # Enable the OpenSSH daemon.
    # openssh.enable = true;

    # X11 things 
    xserver = {
    # Enable X11
      enable = true;
      excludePackages = with pkgs; [xterm];
    # Keymap
      layout = "us";
      xkbVariant = "workman";

    # Enable touchpad support (Laptops).
      # libinput.enable = true;
      
    # KDE Plasma  
      displayManager.sddm.enable = true;
      desktopManager.plasma5.enable = true;	
    };

    # Sound related things
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  # Exclude unwanted default KDE packages
  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
    ark
    gwenview
    okular
    oxygen
    khelpcenter
    konsole
    plasma-browser-integration
    print-manager
  ];
 
  # system profile packages
  environment = {
    shells = with pkgs; [ zsh ];
    systemPackages = with pkgs; [
      alacritty
      brave
      nixos-grub2-theme
      librewolf
      micro
      sof-firmware # Modern laptops may require this
    ];
  };

  # Some programs need SUID wrappers, can be configured further or are started in user sessions.
  programs = {
    zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
    };
  };

  # Make zsh default shell for users
  users.defaultUserShell = pkgs.zsh;

  # Define a user account
  users.users.kris = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    initialPassword = "123"; # Don't forget to set a password with ‘passwd’
  };
  
  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix).
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}

