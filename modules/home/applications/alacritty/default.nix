{
  options,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.nova.applications.alacritty;
in {
  options.nova.applications.alacritty = {
    enable = mkEnableOption (lib.mdDoc "Enable Alacritty, a modern GPU-powered terminal emulator");
  };
  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
    };
  };
}
