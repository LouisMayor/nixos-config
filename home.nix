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

		if [ -n "$(ls -A "$rofi_dir")" ]; then
			cd $rofi_dir
			git clone --depth=1 https://github.com/adi1090x/rofi.git
		fi
		'';
	# todo - dotfiles
    };

    programs.bash = {
        enable = true;
        shellAliases = {
            btw = "echo hello from home.nix";
            unc = "git --git-dir=\"$HOME/nixos-config/.git\" --work-tree=\"/etc/nixos/\"";
            nrs = "sudo nixos-rebuild switch";
	    usrconf = "cd $HOME/.config/";
	    nixconf = "cd /etc/nixos/";
        };
	# https://mynixos.com/home-manager/option/home.sessionVariables
	sessionVariables = {
            usrconf = "$HOME/.config/";
	    nixconf = "/etc/nixos/";
        };
        profileExtra = ''
            if [-z "$WAYLAND_DISPLAY"] && ["$XDG_VTNR" = 1]; then
                exec hyprland
	    fi
        '';
    };

    # programs.fzf.enableBashIntegration = true;
    programs.fzf = {
    	enable = true;
	# defaultCommand;
    };

    programs.firefox.enable = true;

    programs.alacritty.enable = true;

    home.packages = with pkgs; [
    	# cli utils
	gh
	bat
	fzf
	rofi
	# fonts
	nerd-fonts.caskaydia-cove
	nerd-fonts.iosevka
	font-awesome_6
    ];
}
