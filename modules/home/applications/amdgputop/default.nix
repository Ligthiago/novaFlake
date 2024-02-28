{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.applications.amdgputop;
in {
  options.configuration.applications.amdgputop = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable amdgputop module.
      amdgputop is a tool to display AMD GPU usage.
      Source: https://github.com/Umio-Yasuno/amdgpu_top
    '');
    desktopName = mkOpt types.str "amdgpu_top" "Name of desktop file";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      amdgpu_top
    ];

    xdg.desktopEntries."${cfg.desktopName}" = {
      name = "GPU Monitor";
      genericName = "GPU Monitor";
      categories = ["System" "Monitor"];
      type = "Application";
      terminal = false;
      icon = "GPU_Viewer";
      comment = "Graphic card monitoring utility";
      exec = "amdgpu_top --gui";
      settings = {
        Keywords = "Resource;Monitoring;GPU;Statistics;AMD;";
      };
    };
  };
}
