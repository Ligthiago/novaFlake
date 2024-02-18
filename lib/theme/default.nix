{lib, ...}:
with lib; rec {
  # Convert HEX color to Hyprland format
  hexToHyprland = c: "rgb(${builtins.substring 1 7 c})";

  palette = {
    background = {
      dark = "#1e1e1e";
      dim = "#242424";
      normal = "#323232";
      shiny = "#363636";
      bright = "#464646";
      vivid = "#646464";
    };
    foreground = {
      dim = "#989898";
      normal = "#dddddd";
      bright = "#ffffff";
    };
    accents = {
      red = "#ed333b";
      green = "#12b886";
      yellow = "#ffa348";
      blue = "#3584e4";
      magenta = "#c061cb";
      cyan = "#22b8cf";
    };
  };

  geometry = rec {
    borderSize = "1";
    border = "${borderSize}px solid";
    borderRadius = "10px";
  };
}
