{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.applications.btop;
in {
  options.configuration.applications.btop = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable btop module.
      Btop is a terminal resource monitor.
      Source: https://github.com/aristocratos/btop
    '');
    desktopName = mkOpt types.str "btop" "Name of desktop file";
  };

  config = mkIf cfg.enable {
    programs.btop = {
      enable = true;
      settings = {
        color_theme = "nova";
        theme_background = false;
        truecolor = true;
        force_tty = false;
        presets = "cpu:0:default,proc:0:default cpu:0:default,mem:0:default,net:0:default";
        vim_keys = true;
        rounded_corners = true;
        graph_symbol = "block";
        graph_symbol_cpu = "default";
        graph_symbol_mem = "default";
        graph_symbol_net = "default";
        graph_symbol_proc = "default";
        shown_boxes = "cpu mem net proc";
        update_ms = 2000;
        proc_sorting = "cpu direct";
        proc_reversed = false;
        proc_tree = false;
        proc_colors = true;
        proc_gradient = false;
        proc_per_core = false;
        proc_mem_bytes = true;
        proc_cpu_graphs = true;
        proc_info_smaps = false;
        proc_left = false;
        proc_filter_kernel = false;
        cpu_graph_upper = "total";
        cpu_graph_lower = "user";
        cpu_invert_lower = true;
        cpu_single_graph = false;
        cpu_bottom = false;
        show_uptime = true;
        check_temp = true;
        cpu_sensor = "Auto";
        show_coretemp = true;
        cpu_core_map = "";
        temp_scale = "celsius";
        base_10_sizes = false;
        show_cpu_freq = true;
        clock_format = "%X";
        background_update = true;
        custom_cpu_name = "";
        disks_filter = "";
        mem_graph = true;
        mem_below_net = false;
        zfs_arc_ccched = true;
        show_swap = true;
        swap_disk = true;
        show_disks = true;
        only_physical = true;
        use_fstab = true;
        zfs_hide_datasets = false;
        disk_free_priv = false;
        show_io_stat = true;
        io_mode = false;
        io_graphs_combined = false;
        io_graph_speeds = "";
        net_download = 100;
        net_upload = 100;
        net_auto = true;
        net_sync = true;
        net_iface = "";
        show_battery = true;
        selected_battery = "Auto";
        log_level = "WARNING";
      };
    };

    home.file."${config.xdg.configHome}/btop/themes/nova.theme".text = ''
      theme[main_bg]="#1e1e1e"
      theme[main_fg]="#dddddd"
      theme[title]="#dddddd"
      theme[hi_fg]="#12b886"
      theme[selected_bg]="#323232"
      theme[selected_fg]="#dddddd"
      theme[inactive_fg]="#464646"
      theme[proc_misc]="#12b886"
      theme[cpu_box]="#464646"
      theme[mem_box]="#464646"
      theme[net_box]="#464646"
      theme[proc_box]="#464646"
      theme[div_line]="#464646"
      theme[temp_start]="#12b886"
      theme[temp_mid]=""
      theme[temp_end]="#f03e3e"
      theme[cpu_start]="#12b886"
      theme[cpu_mid]=""
      theme[cpu_end]="#f03e3e"
      theme[free_start]="#12b886"
      theme[free_mid]=""
      theme[free_end]=""
      theme[cached_start]="#228be6"
      theme[cached_mid]=""
      theme[cached_end]=""
      theme[available_start]="#fab005"
      theme[available_mid]=""
      theme[available_end]=""
      theme[used_start]="#f03e3e"
      theme[used_mid]=""
      theme[used_end]=""
      theme[download_start]="#12b886"
      theme[download_mid]=""
      theme[download_end]="#f03e3e"
      theme[upload_start]="#22b8cf"
      theme[upload_mid]=""
      theme[upload_end]="#f03e3e"
    '';

    xdg.desktopEntries."${cfg.desktopName}" = {
      name = "Btop";
      genericName = "Resource Monitor";
      categories = ["System" "Monitor"];
      type = "Application";
      terminal = true;
      icon = "btop";
      comment = "Resource monitor for terminal";
      exec = "btop";
      settings = {
        Keywords = "Resource;Monitoring,Processes,Memory,Disks,Network,Statistics;";
      };
    };
  };
}
