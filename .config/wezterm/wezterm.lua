-- config.disable_default_key_bindings = true --disable all default keybindings

local wezterm = require("wezterm")
local icons = wezterm.nerdfonts
local act = wezterm.action

-- local BASE_THEME = 'tokyonight-storm'
-- local colors = wezterm.color.get_builtin_schemes()[BASE_THEME]

-- colors.cursor_bg = 'orange'
-- colors.tab_bar = {
--   background = colors.background,
-- active_tab = {
-- bg_color = colors.background,
-- fg_color = colors.foreground,
-- },
--   inactive_tab = {
--     bg_color = colors.background,
--     fg_color = colors.brights[5], -- blue
--   },
--   new_tab = {
--     bg_color = colors.background,
--     fg_color = colors.background, -- hide button
--   },
-- }

-- local function get_current_working_dir(tab)
--   local current_dir = tab.active_pane.current_working_dir
--   local HOME_DIR = string.format('file://%s', os.getenv 'HOME')

--   return current_dir == HOME_DIR and '~' or string.format('%s', string.gsub(current_dir, '(.*[/\\])(.*)', '%2'))
-- end

-- local function get_process(tab)
--   local process_icons = {
--     ['bash'] = {
--       { Foreground = { Color = 'Grey' } },
--       { Text = icons.dev_terminal },
--       { Text = '  ' }, -- extra space process and folder icons
--     },
--     ['docker-compose'] = {
--       { Foreground = { AnsiColor = 'Aqua' } },
--       { Text = icons.linux_docker },
--       { Text = '  ' }, -- extra space process and folder icons
--     },
--     ['git'] = {
--       { Foreground = { AnsiColor = 'Maroon' } },
--       { Text = icons.mdi_git },
--       { Text = '  ' }, -- extra space process and folder icons
--     },
--     ['node'] = {
--       { Foreground = { Color = 'Lime' } },
--       { Text = icons.dev_nodejs_small },
--       { Text = '  ' }, -- extra space process and folder icons
--     },
--     ['nvim'] = {
--       { Foreground = { AnsiColor = 'Green' } },
--       { Text = icons.custom_vim },
--       { Text = '  ' }, -- extra space process and folder icons
--     },
--     ['vim'] = {
--       { Foreground = { AnsiColor = 'Green' } },
--       { Text = icons.dev_vim },
--       { Text = '  ' }, -- extra space process and folder icons
--     },
--     ['zsh'] = {
--       { Foreground = { Color = 'Grey' } },
--       { Text = icons.dev_terminal },
--       { Text = '  ' }, -- extra space process and folder icons
--     },
--   }

--   local process_name = string.gsub(tab.active_pane.foreground_process_name, '(.*[/\\])(.*)', '%2')
--   local fallback = { { Text = '' } }

--   return wezterm.format(process_icons[process_name] or fallback)
-- end

-- wezterm.on('format-tab-title', function(tab)
--   return wezterm.format {
--     -- Tab index
--     { Text = ' ' },
--     { Attribute = { Italic = true } },
--     { Foreground = { Color = 'Grey' } },
--     { Text = string.format('%s ', tab.tab_index + 1) },
--     { Text = ' ' },
--     'ResetAttributes',

--     Process icon
--     { Text = get_process(tab) },

--     Folder icon
--     { Foreground = { AnsiColor = 'Silver' } },
--     { Text = wezterm.nerdfonts.custom_folder_open },
--     { Text = ' ' },
--     'ResetAttributes',

--     -- Current dir
--     { Attribute = { Italic = true } },
--     { Text = get_current_working_dir(tab) },
--     { Text = '   ' },
--   }
-- end)

return {
	-- Disable all default keybindings
	disable_default_key_bindings = true,
	-- Don't change window size then changing font size
	adjust_window_size_when_changing_font_size = false,
	window_decorations = "NONE",
	window_background_opacity = 0.95,
	term = "xterm-256color",
	-- Font
	font = wezterm.font("JetBrainsMono Nerd Font"),
	font_size = 12.0,
	-- Underline
	underline_thickness = 2,
	underline_position = -3,
	-- Tab bar
	enable_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	tab_bar_at_bottom = true,
	tab_max_width = 50,
	use_fancy_tab_bar = false,
	-- Cursor
	default_cursor_style = "SteadyUnderline",
	-- Colors
	-- color_schemes = {
	-- 	["Custom"] = colors,
	-- },
	-- color_scheme = 'Custom',
	color_scheme = "Catppuccin Macchiato", -- or Macchiato, Mocha, Frappe, Latte
	-- Default Key Assignments https://wezfurlong.org/wezterm/config/default-keys.html

	keys = {
		-- Copy and paste
		{ key = "C", mods = "SHIFT|CTRL", action = act.CopyTo("Clipboard") },
		{ key = "V", mods = "SHIFT|CTRL", action = act.PasteFrom("Clipboard") },

		-- New Window
		{ key = "N", mods = "SHIFT|CTRL", action = act.SpawnWindow },
		{ mods = "SHIFT", key = "UpArrow", action = act.ScrollToPrompt(-1) },
		{ mods = "SHIFT", key = "DownArrow", action = act.ScrollToPrompt(1) },

		-- Misc
		-- { mods = "SUPER", key = "Enter", action = act.ToggleFullScreen },
		-- { mods = "SUPER", key = "z", action = act.TogglePaneZoomState },

		-- Creating panes
		{
			mods = "SUPER",
			key = "-",
			action = act({ SplitVertical = { domain = "CurrentPaneDomain" } }),
		},
		{
			mods = "SUPER|ALT",
			key = "-",
			action = act({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
		},

		-- Close pane
		{ mods = "ALT", key = "w", action = wezterm.action.CloseCurrentPane({ confirm = false }) },
		-- Navigating panes
		-- { mods = "SUPER", key = "h", action = act({ ActivatePaneDirection = "Left" }) },
		-- { mods = "SUPER", key = "j", action = act({ ActivatePaneDirection = "Down" }) },
		-- { mods = "SUPER", key = "k", action = act({ ActivatePaneDirection = "Up" }) },
		-- { mods = "SUPER", key = "l", action = act({ ActivatePaneDirection = "Right" }) },

		-- New tab
		{ key = "T", mods = "SHIFT|CTRL", action = act.SpawnTab("CurrentPaneDomain") },

		-- Cycling through tabs
		{ mods = "SUPER|ALT", key = "LeftArrow", action = act({ ActivateTabRelative = -1 }) },
		{ mods = "SUPER|ALT", key = "RightArrow", action = act({ ActivateTabRelative = 1 }) },
		{ key = "Tab", mods = "CTRL", action = act.ActivateTabRelative(1) },
		{ key = "Tab", mods = "SHIFT|CTRL", action = act.ActivateTabRelative(-1) },

		-- Activate tabs
		{ key = "!", mods = "SHIFT|CTRL", action = act.ActivateTab(0) },
		{ key = "@", mods = "SHIFT|CTRL", action = act.ActivateTab(1) },
		{ key = "#", mods = "SHIFT|CTRL", action = act.ActivateTab(2) },
		{ key = "$", mods = "SHIFT|CTRL", action = act.ActivateTab(3) },
		{ key = "%", mods = "SHIFT|CTRL", action = act.ActivateTab(4) },
		{ key = "^", mods = "SHIFT|CTRL", action = act.ActivateTab(5) },
		{ key = "&", mods = "SHIFT|CTRL", action = act.ActivateTab(6) },
		{ key = "*", mods = "SHIFT|CTRL", action = act.ActivateTab(7) },
		{ key = "(", mods = "SHIFT|CTRL", action = act.ActivateTab(8) },

		-- Moving tabs
		{ mods = "SUPER|SHIFT", key = "LeftArrow", action = act({ MoveTabRelative = -1 }) },
		{ mods = "SUPER|SHIFT", key = "RightArrow", action = act({ MoveTabRelative = 1 }) },

		-- Fix readline "undo"
		{ mods = "CTRL", key = "/", action = act({ SendString = "\x1f" }) },

		-- Reload configuration
		{ key = "R", mods = "SHIFT|CTRL", action = act.ReloadConfiguration },
	},
}
