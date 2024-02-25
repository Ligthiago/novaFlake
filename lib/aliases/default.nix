{lib, ...}:
with lib; rec {
  aliases = {
    global = {
      ll = "ls -l";
      la = "ls -a";
      lla = "ls -la";
      search = "s -p";
    };
    bash = {};
    zsh = {};
    fish = {};
    nushell = {};
  };
}
