{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.modules.applications.amdgputop;
in {
  options.modules.applications.amdgputop = {
     enable = mkOptEnable (lib.mdDoc ''
      Enable amdgputop module.
      amdgputop is a tool to display AMD GPU usage.
      Source: https://github.com/Umio-Yasuno/amdgpu_top
    '');
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      amdgpu_top
    ];

    xdg.desktopEntries."amdgpu_top" = {
      name = "GPU Monitor";
      genericName = "GPU Monitor";
      categories = ["System" "Monitor"];
      type = "Application";
      terminal = false;
      icon = "GPU_Viewer";
      comment = "Graphic card monitoring utility";
      exec = "amdgpu_top --gui";
      settings = {
        Keywords = "Resource;Monitoring,GPU,Statistics,AMD;";
      };
    };
  };
}
