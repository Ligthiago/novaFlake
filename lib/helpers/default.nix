{lib, ...}:
with lib; rec {
  enabled = {enable = true;};
  disabled = {enable = false;};

  mkOpt = type: default: description:
    mkOption {
      inherit type default;
      description = lib.mdDoc "${description.text}";
    };

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
