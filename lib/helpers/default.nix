{
  lib,
  ...
}:
with lib; rec {
  enabled = {enable = true;};
  disabled = {enable = false;};

  # userHome = config.home.homeDirectory;
  # userConfig = config.xdg.configHome;

  mkOptEnable = name:
    mkOption {
      default = false;
      type = types.bool;
      example = true;
      description =
        if name ? _type && name._type == "mdDoc"
        then lib.mdDoc "${name.text}"
        else "${name}";
    };
}
