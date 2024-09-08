{ config, lib, pkgs, ... }:

{ 
  imports = [ # Include the results of the hardware scan.
    # TODO uncomment when installing ./hardware-configuration.nix
  ];

  nix.settings = {
    # Manual optimise storage: nix-store --optimise
    # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
    auto-optimise-store = true;
    builders-use-substitutes = true;
    # enable flakes globally
    experimental-features = ["nix-command" "flakes"];
  };

  networking.hostName = "nixrouter";
  time.timeZone = "America/Los_Angeles";

  users.groups.noah.gid = 1000;
  users.users.noah = {
    isNormalUser = true;
    uid = 1000;
    home = "/home/noah";
    extraGroups = [ "networkmanager" "noah" "wheel" ];
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
      "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBG5/igfDm33qmKoujL1y8F/D2EInyUyJJE4fHZjZXKRYcDfrDp30QEd6CM7BFNJMREyzeZe4CBopIZld77YjKus= noah@WIN11-DESKTOP"
      "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBBY2D9VRvcblvSxfSWZKG59snFUoHbIuMrUohFhmjjtq0avSbiVUGRi1xIA3oUpsPkkn7qrNR5paCdYrECip3nQ= noah@nixos-laptop"
      "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBCD8aFvjd6RhUbJzvuhnyBiTmXX+PQ0uzs2ju85EnMUm+Wq7uCZ+AC8tO9IN0YiwEpIwhtNDJC/ZwzMSuEWIy9M= u0_a290@localhost"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDUjdiPWiGQ3o/xbdPWYtEK37tsSSu+rA8VLWneOkoEtIU1F8HyjwNKWBjn+Y/8syQUF3TghV8N2d2/HPGyltccgVfPVfdh+MKLwgVXAjnLA2IhMpLnghDSQFHNvSs/RIwi1ETHP5pdiPVLkzV2wv3sfSLiayAwXiyh0D5RKUUAlY/0LKrOOvsv/1slg6Q2pk8W4u2WCJhyVGqGmFv7X71U/aX7izvyyui/AJRS2XnIcCjgB439QRXy9yMyyFQfi9C0WV38u/grq0AUuDvVuXl1jzTTDw9M9Gk7yILnVTlsK0mtNwxR54Q2ay9EhB490sa//WFCVqoYiZHjvcwFc7qHAf+en1fr5mBRlaoAZRXaq3wKuhVynTS7w92GhKdQxjPhJxbML8yqVaYvsJ+USYIBowctaVqXoDBzM+PbAuvfQcs6Mff/BzGlzwOI5RPYIEjLKDva/mBVQWm77PdqHW4r59TPE7eY6T0KqGTvto0X+N0NiQwsLHB0p+9hpEJ/3XU= u0_a178@localhost"
    ];
  };

  services.openssh = {
    enable = true;
    settings.KbdInteractiveAuthentication = false;
  };

  programs.fish.enable = true;

  # List packages installed in system profile. To search, run: $ nix search wget
  environment.variables = { EDITOR = "nvim"; };
  environment.systemPackages = with pkgs; [
    comma
    eza
    fish
    gcc
    git
    htop
    lm_sensors
    memtester
    neofetch
    neovim
    nix-index
    stress
    tmux
    vim
    watch
    wget
  ];
}

