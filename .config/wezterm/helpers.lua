-- Dummy helpers.lua that should should live in ~/.config/wezterm/helpers.lua

local wezterm = require 'wezterm'

-- This is the module table that we will export
local module = {}

-- This function is private to this module and is not visible outside
local function private_helper()
  wezterm.log_error 'This is a locally defined helper!'
end

-- define a function in the module table.
-- Only functions defined in `module` will be exported to
-- code that imports this module.
-- The suggested convention for making modules that update
-- the config is for them to export an `apply_to_config`
-- function that accepts the config object, like this:

function module.apply_to_config(config)
  private_helper()
--  config.color_scheme = 'Abernathy'
--  config.color_scheme = 'Builtin Tango Dark'
--  config.color_scheme = 'Calamity'
--  config.color_scheme = 'Dark Pastel'
--  config.color_scheme = 'Dark+'
--  config.color_scheme = 'Dracula+' -- also with no "+"
--  config.font = wezterm.font('JetBrains Mono', {})
  config.font = wezterm.font('Monaco', {})
  config.line_height = 0.92
  
  local act = wezterm.action
  config.keys = {
  	{ -- rename the tab with cmd+shift+R
  		key = 'R',
  		mods = 'CMD|SHIFT',
  		action = act.PromptInputLine {
  			description = 'Enter new name for tab',
  			action = wezterm.action_callback(function(window, _, line)
  			if line then
  				window:active_tab():set_title(line)
  			end
  			end)
  		}
  	},
  	{ -- not to intrude into the Joe's ctrl+shift+_ command to undo thing
  		key = '_',
  		mods = 'CTRL|SHIFT',
  		action = 'DisableDefaultAssignment'
  	},
  	{ -- no to intrude into the native MacOS Option+F12 chain
  		key = 'F12',
  		mods = 'OPT',
  		action = wezterm.action.HideApplication
  	},
  	-- turn back normal behaviour of moving cursor back and forth by one word with Option+<Arrow Right/Left>
  	{
  		key = 'LeftArrow',
  		mods = 'OPT',
  		action = act.SendKey { key = 'b', mods = 'ALT' }
  	},
  	{
  		key = 'RightArrow',
  		mods = 'OPT',
  		action = act.SendKey { key = 'f', mods = 'ALT' }
  	},
  	-- Switch tabs with Command+<Arrow Right/Left>
  	{
  		key = 'LeftArrow',
  		mods = 'CMD',
  		action = act { ActivateTabRelative = -1 }
  	},
  	{
  		key = 'RightArrow',
  		mods = 'CMD',
  		action = act { ActivateTabRelative = 1 }
  	},
  	-- Move tabs with Command+Shift+<Arrow Right/Left>
  	{
  		key = 'LeftArrow',
  		mods = 'CMD|SHIFT',
  		action = act { MoveTabRelative = -1 }
  	},
  	{
  		key = 'RightArrow',
  		mods = 'CMD|SHIFT',
  		action = act { MoveTabRelative = 1 }
  	},
  	{ -- Launch tabs list
  		key = 'UpArrow',
  		mods = 'CMD',
  		action = act.ShowTabNavigator
  	},
  	{ -- Split pane Veritcal
  		key = '|',
  		mods = 'CTRL|OPT|SHIFT',
  		action = act.SplitHorizontal
  	},
  }

end

-- return our module table
return module
