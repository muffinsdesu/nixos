{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz";
  aagl-gtk-on-nix = import (builtins.fetchTarball "https://github.com/ezKEa/aagl-gtk-on-nix/archive/main.tar.gz");
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
  	      variant = "workman"; # Not working?
  	    };
  	    
  	    packages = with pkgs; [
  	    	aagl-gtk-on-nix.anime-game-launcher
  	    	btop
  	    ];
  	  };
  	  programs = {
  	     zsh = {
  	       enable = true;
  	       dotDir = ".config/zsh";
  	       history = {
  	       	path = "$ZDOTDIR/.history";
  	       	save = 1000;
  	       };
  	       initExtra = ''
  	         unsetopt nomatch
  	       '';	
  	     };
  	  };
  	       
  	}; 
  };
}
