dofile_once("data/scripts/lib/mod_settings.lua")

local mod_id = "blood_hurts"
mod_settings_version = 1

local mod_settings =
{
	{
        id = "dunk_mode",
		ui_name = "Dunk Mode",
		ui_description = "A special mode for god gamers only.",
        value_default = false,
        scope = MOD_SETTING_SCOPE_NEW_GAME
	}
}

-- This function is called to display the settings UI for this mod. Your mod's settings wont be visible in the mod settings menu if this function isn't defined correctly.
function ModSettingsUpdate( init_scope )
    local old_version = mod_settings_get_version( mod_id )
    mod_settings_update( mod_id, mod_settings, init_scope )
end

function ModSettingsGuiCount()
    return mod_settings_gui_count( mod_id, mod_settings )
end

function ModSettingsGui( gui, in_main_menu )
    mod_settings_gui( mod_id, mod_settings, gui, in_main_menu )
end