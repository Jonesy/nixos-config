.PHONY: switch
switch:
		home-manager switch --flake .#thinkpad

.PHONY: clean
clean:
		sudo nix-collect-garbage --delete-older-than 30d
		sudo nixos-rebuild boot
	
.PHONY: update
update:
		nix flake update
		sudo nixos-rebuild switch --flake .
		home-manager switch --flake .
