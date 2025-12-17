{ config, pkgs, lib, ... }:

{
    home.username = "louis";
    home.homeDirectory = "/home/louis";
    home.stateVersion = "25.05";

    # add custom cli things here
    home.activation = {
        # https://github.com/adi1090x/rofi?tab=readme-ov-file
		setup_rofi = lib.hm.dag.entryAfter ["writeBoundary"] ''
			rofi_dir="$HOME/.config/rofi/"
			if [ ! -d "$rofi_dir" ]; then
				mkdir $rofi_dir
			fi

			if [ -z "$(ls -A "$rofi_dir")" ]; then
				cd $rofi_dir
				${pkgs.git}/bin/git clone --depth=1 https://github.com/adi1090x/rofi.git
			fi
		'';
		# create directory to store git repos
		# https://github.com/bobwhitelock/dotfiles/blob/master/bin/clone - interesting
		setup_git_folder = lib.hm.dag.entryAfter ["writeBoundary"] ''
			git_dir="$HOME/git/"
			if [ ! -d "$git_dir" ]; then
				mkdir $git_dir
			fi
		'';

		# todo - dotfiles
    };

    programs = {
    	bash = {
       		enable = true;
			enableCompletion = true;
       	 	shellAliases = {
       	 	    btw = "echo hello from home.nix";
       	 	    nrs = "sudo nixos-rebuild switch --flake $HOME/.config/nixos/";
       	 	    usrconf = "cd $HOME/.config/";
       	 	    nixconf = "cd $HOME/.config/nixos/";
       	 	};
       	 	# https://mynixos.com/home-manager/option/home.sessionVariables
       	 	sessionVariables = {
       	 	    usrconf = "$HOME/.config/";
       	 	    nixconf = "$HOME/.config/nixos/";
       	 	};
       	 	profileExtra = ''
       	 	    if [-z "$WAYLAND_DISPLAY"] && ["$XDG_VTNR" = 1]; then
       	 	        exec hyprland
       	 	    fi
       	 	'';
			bashrcExtra = ''
			'';
		};
    	fzf = {
    		enable = true;
			enableBashIntegration = true;
		};
		# already enabled system-wide
		neovim = {
			enable	 = true;
			vimAlias = true;
			viAlias	 = true;
			# basic config - would be overridden by dotfile config later
			extraConfig = ''
				set number relativenumber
				set shiftwidth=4
				set tabstop=4
				set smarttab
			'';
		};
		tmux 		= {	enable = true; };
		rofi 		= {	enable = true; };
		git 		= {	enable = true; };
		firefox 	= {	enable = true; };
		alacritty 	= {	enable = true; };
		direnv	= {	
			enable = true;
			enableBashIntegration = true;
		};
    };

    
    home.packages = with pkgs; [
    	# cli utils
		gh
		bat
		# fonts
		nerd-fonts.caskaydia-cove
		nerd-fonts.iosevka
		font-awesome_6
    ];
}
