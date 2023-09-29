local wezterm = require 'wezterm'
local gpus = wezterm.gui.enumerate_gpus()
local act = wezterm.action

-- local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
local SOLID_RIGHT_ARROW = utf8.char(0xe0b0)

local Grey = "#0f1419"
local LightGrey = "#191f26"

local TAB_BAR_BG = "#121222"
local ACTIVE_TAB_BG = "#8581c6"
local ACTIVE_TAB_FG = "#cdd6f4"
local HOVER_TAB_BG = "#121222"
local HOVER_TAB_FG = "#cdd6f4"
local NORMAL_TAB_BG = "0a0a19"
local NORMAL_TAB_FG = "#cdd6f4"

local BGCOLOR1 = "#242437"
local BGCOLOR2 = "#1a1a32"
local BGCOLOR3 = "#121222"

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
    panes = panes
    config = config
    max_width = max_width

    local background = NORMAL_TAB_BG
    local foreground = NORMAL_TAB_FG

    local is_first = tab.tab_id == tabs[1].tab_id
    local is_last = tab.tab_id == tabs[#tabs].tab_id

    if tab.is_active then
        background = ACTIVE_TAB_BG
        foreground = ACTIVE_TAB_FG
    elseif hover then
        background = HOVER_TAB_BG
        foreground = HOVER_TAB_FG
    end

    local leading_fg = NORMAL_TAB_FG
    local leading_bg = background

    local trailing_fg = background
    local trailing_bg = NORMAL_TAB_BG

    if is_first then
        leading_fg = TAB_BAR_BG
    else
        leading_fg = NORMAL_TAB_BG
    end

    if is_last then
        trailing_bg = TAB_BAR_BG
    else
        trailing_bg = NORMAL_TAB_BG
    end

    local title = tab.active_pane.title
    -- broken?
    -- local title = " " .. wezterm.truncate_to_width(tab.active_pane.title, 30) .. " "

    return {
        {Attribute={Italic=false}},
        {Attribute={Intensity=hover and "Bold" or "Normal"}},
        {Background={Color=leading_bg}},  {Foreground={Color=leading_fg}},
        {Text=SOLID_RIGHT_ARROW},
        {Background={Color=background}},  {Foreground={Color=foreground}},
        {Text=" "..title.." "},
        {Background={Color=trailing_bg}}, {Foreground={Color=trailing_fg}},
        {Text=SOLID_RIGHT_ARROW},
    }
end)

return {
    window_decorations = "RESIZE",
    native_macos_fullscreen_mode = true,


    hide_tab_bar_if_only_one_tab = true,
    tab_bar_at_bottom = true,
    use_fancy_tab_bar = false,
    enable_tab_bar = true,
    tab_max_width = 32,

    leader = { key="b", mods="ALT", timeout_milliseconds=1000 },
    inactive_pane_hsb = {
        saturation = 0.5,
        brightness = 0.5,
    },

    color_scheme = "",
    colors = {
        tab_bar = {
            background = TAB_BAR_BG,
        },
    },

    tab_bar_style = {
        new_tab = wezterm.format{
            {Background={Color=HOVER_TAB_BG}},	{Foreground={Color=TAB_BAR_BG}},	{Text=SOLID_RIGHT_ARROW}, {Background={Color=HOVER_TAB_BG}}, {Foreground={Color=HOVER_TAB_FG}},
            {Text=" + "},
            {Background={Color=TAB_BAR_BG}},	{Foreground={Color=HOVER_TAB_BG}},  {Text=SOLID_RIGHT_ARROW},
        },
        new_tab_hover = wezterm.format{
            {Attribute={Italic=false}},
            {Attribute={Intensity="Bold"}},
            {Background={Color=NORMAL_TAB_BG}},	{Foreground={Color=TAB_BAR_BG}},	{Text=SOLID_RIGHT_ARROW}, {Background={Color=NORMAL_TAB_BG}}, {Foreground={Color=NORMAL_TAB_FG}},
            {Text=" + "},
            {Background={Color=TAB_BAR_BG}},	{Foreground={Color=NORMAL_TAB_BG}},	{Text=SOLID_RIGHT_ARROW},
        },
    },

    bold_brightens_ansi_colors = true,
    window_background_opacity = 0.7,
    default_cursor_style = 'SteadyBlock',
    font_size = 12,
    force_reverse_video_cursor = true,
    font = wezterm.font({
        family="Fira Code",
    }),
    window_background_gradient={
        orientation = "Vertical",
        colors = {
            BGCOLOR1,
            BGCOLOR2,
            BGCOLOR3,
        },
        blend = "Rgb",
    },
    text_background_opacity = 1, --0.95
    disable_default_key_bindings = true,

    audible_bell = "Disabled", -- WHAT THE FUCK, MY EARS!@#@#!@!#!@#!@#
    window_close_confirmation = 'NeverPrompt',
    skip_close_confirmation_for_processes_named = { 'bash', 'sh', 'zsh', 'fish', 'tmux' },
    keys = {
        -- Split actions
        { key="-",  mods = "ALT",           action = act{ SplitVertical={ domain="CurrentPaneDomain" } } },
        { key="\\", mods = "ALT",           action = act{ SplitHorizontal={ domain="CurrentPaneDomain" } } },
        { key="h",  mods = "ALT",           action = act{ ActivatePaneDirection="Left" } },
        { key="l",  mods = "ALT",           action = act{ ActivatePaneDirection="Right" } },
        { key="j",  mods = "ALT",           action = act{ ActivatePaneDirection="Down" } },
        { key="k",  mods = "ALT",           action = act{ ActivatePaneDirection="Up" } },
        { key="w",  mods = "ALT",           action = act{ CloseCurrentPane={confirm=false} } },
        { key="w",  mods = "CTRL|ALT",      action = act.CloseCurrentTab { confirm = false } },
        { key="h",  mods = "CTRL|ALT",      action = act.AdjustPaneSize { 'Left', 1 } },
        { key="l",  mods = "CTRL|ALT",      action = act.AdjustPaneSize { 'Right', 1 } },
        { key="j",  mods = "CTRL|ALT",      action = act.AdjustPaneSize { 'Down', 1 } },
        { key="k",  mods = "CTRL|ALT",      action = act.AdjustPaneSize { 'Up', 1 } },
        -- Tab actions                      
        { key="t",  mods = 'ALT',           action = act.SpawnTab 'DefaultDomain' },
        { key="t",  mods = 'CTRL|ALT',      action = act.ShowTabNavigator },
        { key="h",  mods = 'CTRL|ALT',      action = act.ActivateTabRelative(-1) },
        { key="l",  mods = 'CTRL|ALT',      action = act.ActivateTabRelative(1) },
        { key="h", mods = 'CTRL|ALT|SHIFT', action = act.MoveTabRelative(-1) },
        { key="l", mods = 'CTRL|ALT|SHIFT', action = act.MoveTabRelative(1) },
        { key="1",  mods = 'CTRL|ALT',      action = act.ActivateTab(0) },
        { key="2",  mods = 'CTRL|ALT',      action = act.ActivateTab(1) },
        { key="3",  mods = 'CTRL|ALT',      action = act.ActivateTab(2) },
        { key="4",  mods = 'CTRL|ALT',      action = act.ActivateTab(3) },
        { key="5",  mods = 'CTRL|ALT',      action = act.ActivateTab(4) },
        { key="6",  mods = 'CTRL|ALT',      action = act.ActivateTab(5) },
        { key="7",  mods = 'CTRL|ALT',      action = act.ActivateTab(6) },
        { key="8",  mods = 'CTRL|ALT',      action = act.ActivateTab(7) },
        { key="9",  mods = 'CTRL|ALT',      action = act.ActivateTab(8) },
        -- misc                             
        { key="c",  mods = 'CTRL|SHIFT',    action = act{ CopyTo="Clipboard" } },
        { key="v",  mods = 'CTRL|SHIFT',    action = act{ PasteFrom="Clipboard" } },
        { key="f",  mods = 'CTRL|SHIFT',    action = act.Search{ CaseSensitiveString="" } },
        { key="x",  mods = 'CTRL|SHIFT',    action = act.ActivateCopyMode },
        { key="Space", mods = 'CTRL|SHIFT', action = act.QuickSelect },
        { key="p",  mods = 'CTRL|SHIFT',    action = act.ActivateCommandPalette },
        { key="l",  mods = 'CTRL|SHIFT',    action = act.ShowDebugOverlay },
        { key="m",  mods = 'CTRL|ALT',      action = act.Hide },
        { key="-",  mods = 'CTRL|SHIFT',    action = act.DecreaseFontSize },
        { key="=",  mods = 'CTRL|SHIFT',    action = act.IncreaseFontSize },
        { key="0",  mods = 'CTRL|SHIFT',    action = act.ResetFontSize },
    },
    --[[webgpu_preferred_adapter = {
        backend = 'Vulkan',
        device = 26591,
        device_type = 'DiscreteGpu',
        driver = 'radv',
        driver_info = 'Mesa 23.2.0-rc2',
        name = 'AMD Radeon RX 590 Series (RADV POLARIS10)',
        vendor = 4098,
    },--]]

    webgpu_preferred_adapter = gpus[1],
    front_end = 'WebGpu',

    animation_fps = 60,
    max_fps = 144,
}
