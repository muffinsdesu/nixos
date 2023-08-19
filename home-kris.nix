{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];
  
  home-manager = {
  	useGlobalPkgs = true;
  	useUserPackages = true;
  	users.kris = {
  	  /* The home.stateVersion option does not have a default and must be set */
  	  home = {
  	    stateVersion = "23.05";
  	    keyboard = {
  	      layout = "us";
  	      variant = "workman";
  	    };
  	    
  	    packages = with pkgs; [
  	    	btop
  	    ];
  	  };     
  	}; 
  };

  programs = {
  	zsh = {
  	  enable = true;
  	  autosuggestions.enable = true;
  	  syntaxHighlighting.enable = true;	
  	};
  };
}
