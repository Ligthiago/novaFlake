#!/usr/bin/env nu

$env.config = {
    show_banner: false
    table: {
        mode: rounded
        index_mode: auto
        show_empty: true
        padding: { left: 1, right: 1 }
        header_on_separator: false
        trim: {
            methodology: wrapping 
            wrapping_try_keep_words: true
            truncating_suffix: "..."
        }
    }
    completions: {
        case_sensitive: false 
        quick: true 
        partial: true 
        algorithm: "fuzzy"
        external: {
            max_results: 20
        }
    }
    error_style: "fancy"
    use_grid_icons: true
    ls: {
        use_ls_colors: true 
        clickable_links: true
    }
    rm: {
        always_trash: true
    }
    menus: [
        {
            name: completion_menu
            only_buffer_difference: false
            marker: "| "
            type: {
                layout: columnar
                columns: 4
                col_width: 20
                col_padding: 2
            }
            style: {
                text: green
                selected_text: {attr: r}
                description_text: normal
                match_text: {attr: u}
                selected_match_text: {attr: ur}
            }
        }
        {
            name: ide_completion_menu
            only_buffer_difference: false
            marker: ""
            type: {
                layout: ide
                min_completion_width: 0,
                max_completion_width: 100,
                max_completion_height: 20,
                padding: 0,
                border: false,
                cursor_offset: 0,
                description_mode: "prefer_right"
                min_description_width: 0
                max_description_width: 50
                max_description_height: 10
                description_offset: 1
                correct_cursor_pos: false
            }
            style: {
                text: green
                selected_text: {attr: r}
                description_text: yellow
                match_text: {attr: u}
                selected_match_text: {attr: ur}
            }
        }
    ]
     keybindings: [
        {
            name: completion_menu
            modifier: control
            keycode: char_n
            mode: [emacs vi_normal vi_insert]
            event: {
                until: [
                    { send: menu name: completion_menu }
                    { send: menunext }
                    { edit: complete }
                ]
            }
        }
        {
            name: ide_completion_menu
            modifier: none
            keycode: tab
            mode: [emacs vi_normal vi_insert]
            event: {
                until: [
                    { send: menu name: ide_completion_menu }
                    { send: menunext }
                    { edit: complete }
                ]
            }
        }
        {
            name: move_to_line_start
            modifier: control
            keycode: char_s
            mode: [emacs, vi_normal, vi_insert]
            event: {edit: movetolinestart}
        }
        {
            name: move_to_line_start
            modifier: control
            keycode: char_e
            mode: [emacs, vi_normal, vi_insert]
            event: {edit: movetolineend}
        }
    ]

}
